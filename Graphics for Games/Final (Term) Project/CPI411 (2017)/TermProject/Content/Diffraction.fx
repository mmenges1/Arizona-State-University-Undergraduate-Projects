float4x4 World;
float4x4 View;
float4x4 Projection;
float4x4 WorldInverseTranspose;
float3 lightPosition;
float3 CameraPosition;
float4 hiLiteColor;
float roughness = 1;
float distance = 1;
texture decalMap;
texture environmentMap;

samplerCUBE SkyBoxSampler = sampler_state
{
	texture = <environmentMap>;
	magfilter = LINEAR;
	minfilter = LINEAR;
	mipfilter = LINEAR;
	AddressU = Mirror;
	AddressV = Mirror;
};
sampler tsampler1 = sampler_state {
	texture = <decalMap>;
	magfilter = LINEAR;
	minfilter = LINEAR;
	mipfilter = LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
};
struct VertexShaderInput
{
	float4 Position : POSITION0;
	float4 Normal : NORMAL0;
	float4 Tangent : TEXCOORD0;
};
struct VertexShaderOutput
{
	float4 Position : POSITION0;
	float3 Normal : TEXCOORD1;
	float3 Tangent : TEXCOORD0;
};

VertexShaderOutput DiffractionVertexShaderFunction(VertexShaderInput input)
{
	VertexShaderOutput output;
	float4 worldPosition = mul(input.Position, World);
	float4 viewPosition = mul(worldPosition, View);
	output.Position = mul(viewPosition, Projection);
	output.Normal = normalize(mul(input.Normal, WorldInverseTranspose).xyz);
	output.Tangent = normalize(mul(input.Tangent, WorldInverseTranspose).xyz);
	return output;
}

float4 DiffractionPixelShaderFunction(VertexShaderOutput input) : COLOR0
{
	float4 worldPosition = mul(input.Position, World);
	float3 L = normalize(lightPosition - input.Position.xyz);
	float3 V = normalize(CameraPosition - input.Position.xyz);
	float3 H = L + V;
	float3 N = normalize(input.Normal);
	float3 T = normalize(input.Tangent);
	float3 I = normalize(worldPosition.xyz - CameraPosition);
	float3 R = reflect(I, normalize(N));
	float4 reflectedColor = texCUBE(SkyBoxSampler, R);

	float u = dot(T, H) * distance;
	float halfNorm = dot(N, H);
	float expon = roughness * u / halfNorm;
	float3 shapeParam = exp(-expon * expon);
	float4 anistropic = (hiLiteColor + reflectedColor) * float4(shapeParam.x, shapeParam.y, shapeParam.z, 1);

	if (u < 0) u = -u;

	float4 colorDiff = float4(0, 0, 0, 1);
	for (int i = 1; i < 15; i++)
	{
		float y = 2 * u / i - 1;
		float3 x = float3(4 * (y - 0.75), 4 * (y - 0.5), 4 * (y - 0.25));
		float3 y1 = 1 - x * x;
		y1 = max(y1, float3 (0, 0, 0));
		colorDiff.xyz += y1;

	}

	float4 color = colorDiff + anistropic;
	return color;
}

technique Diffraction
{
	pass Pass1
	{
		VertexShader = compile vs_4_0 DiffractionVertexShaderFunction();
		PixelShader = compile ps_4_0 DiffractionPixelShaderFunction();
	}
}