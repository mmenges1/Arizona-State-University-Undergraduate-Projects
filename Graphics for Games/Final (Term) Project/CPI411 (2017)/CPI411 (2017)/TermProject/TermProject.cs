using CPI411.SimpleEngine;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace TermProject
{
    public class TermProject : Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;

        SpriteFont font;

        Effect effect;
        Model model;
        Texture2D texture;
        SkyBox skybox;
        Vector3 camOffset = new Vector3(0, 0, 0);
        Vector3 camPosition = new Vector3(0, 0, 35);
        Vector3 lightPosition = new Vector3(0, 0, 1);

        Matrix world = Matrix.CreateTranslation(0, 0, 0);
        Matrix view = Matrix.CreateLookAt(new Vector3(0, 0, 35), new Vector3(0, 0, 0), Vector3.UnitY);
        Matrix projection = Matrix.CreatePerspectiveFieldOfView(MathHelper.ToRadians(45), 800f / 600f, 0.1f, 100f);

        float lightX = 10;
        float lightY = 10;
        float camAngleX = 0;
        float camAngleY = 0;
        float distance = 35.0f;

        MouseState previousMouseState;
        KeyboardState previousKeyState;
        Model CD, torus, cube, sphere, teapot;
        bool showMenu, showValues;

        Vector4 ambient = new Vector4(0.1f, 0.1f, 0.1f, 1);
        float roughness = 0.1f;
        Vector4 hilightColor = new Vector4(0, 0, 0, 0);
        float waveDistance = 1.0f;
        Vector4 specularColor = new Vector4(1, 1, 1, 1);
        public TermProject()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
            IsMouseVisible = true;
        }

        protected override void Initialize()
        {
            base.Initialize();
        }

        protected override void LoadContent()
        {
            spriteBatch = new SpriteBatch(GraphicsDevice);

            font = Content.Load<SpriteFont>("font");
            CD = Content.Load<Model>("CD");
            torus = Content.Load<Model>("torus");
            cube = Content.Load<Model>("box");
            teapot = Content.Load<Model>("teapot");
            sphere = Content.Load<Model>("sphere");
            model = CD;
            string[] skyboxTextures = { "skybox/hills_negx", "skybox/hills_posx", "skybox/hills_negy", "skybox/hills_posy", "skybox/hills_negz", "skybox/hills_posz" };
            skybox = new SkyBox(skyboxTextures, Content, GraphicsDevice);
            effect = Content.Load<Effect>("Diffraction");
        }

        protected override void UnloadContent()
        {
        }

        protected override void Update(GameTime gameTime)
        {
            if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed || Keyboard.GetState().IsKeyDown(Keys.Escape))
                Exit();
            MouseState currentMouseState = Mouse.GetState();
            bool shift = false;
            Keys[] pressedKeys = Keyboard.GetState().GetPressedKeys();
            foreach (Keys key in pressedKeys)
                if (key == Keys.LeftShift || key == Keys.RightShift) shift = true;
            if (Keyboard.GetState().IsKeyDown(Keys.Up)) lightX += 1.0f;
            if (Keyboard.GetState().IsKeyDown(Keys.Down)) lightX -= 1.0f;
            if (Keyboard.GetState().IsKeyDown(Keys.Left)) lightX += 1.0f;
            if (Keyboard.GetState().IsKeyDown(Keys.Right)) lightX -= 1.0f;

            if (Keyboard.GetState().IsKeyDown(Keys.D1)) model = cube;
            if (Keyboard.GetState().IsKeyDown(Keys.D2)) model = sphere;
            if (Keyboard.GetState().IsKeyDown(Keys.D3)) model = torus;
            if (Keyboard.GetState().IsKeyDown(Keys.D4)) model = teapot;
            if (Keyboard.GetState().IsKeyDown(Keys.D5)) model = CD;

            if (Keyboard.GetState().IsKeyDown(Keys.H) && !previousKeyState.IsKeyDown(Keys.H)) showValues = !showValues;
            if (Keyboard.GetState().IsKeyDown(Keys.OemQuestion) && !previousKeyState.IsKeyDown(Keys.OemQuestion)) showMenu = !showMenu;

            if (Keyboard.GetState().IsKeyDown(Keys.D) && !shift) waveDistance = MathHelper.Clamp(waveDistance + 0.01f, 0f, 5.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D) && shift) waveDistance = MathHelper.Clamp(waveDistance - 0.01f, 0f, 5.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.A) && !shift) roughness = MathHelper.Clamp(roughness + 0.01f, -0.5f, 1.5f);
            if (Keyboard.GetState().IsKeyDown(Keys.A) && shift) roughness = MathHelper.Clamp(roughness - 0.01f, -0.5f, 1.5f);


            if (Keyboard.GetState().IsKeyDown(Keys.D6) && !shift) hilightColor.X = MathHelper.Clamp(hilightColor.X + 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D6) && shift) hilightColor.X = MathHelper.Clamp(hilightColor.X - 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D7) && !shift) hilightColor.Y = MathHelper.Clamp(hilightColor.Y + 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D7) && shift) hilightColor.Y = MathHelper.Clamp(hilightColor.Y - 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D8) && !shift) hilightColor.Z = MathHelper.Clamp(hilightColor.Z + 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D8) && shift) hilightColor.Z = MathHelper.Clamp(hilightColor.Z - 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D9) && !shift) hilightColor.W = MathHelper.Clamp(hilightColor.W + 0.01f, 0f, 1.0f);
            if (Keyboard.GetState().IsKeyDown(Keys.D9) && shift) hilightColor.W = MathHelper.Clamp(hilightColor.W - 0.01f, 0f, 1.0f);

            if (currentMouseState.LeftButton == ButtonState.Pressed && previousMouseState.LeftButton == ButtonState.Pressed)
            {
                camAngleY -= (previousMouseState.X - currentMouseState.X) / 100.0f;
                camAngleX -= (previousMouseState.Y - currentMouseState.Y) / 100.0f;
            }
            if (Mouse.GetState().RightButton == ButtonState.Pressed && previousMouseState.RightButton == ButtonState.Pressed)
            {
                float offsetX = (previousMouseState.X - currentMouseState.X) / 100.0f;
                distance += offsetX;
            }
            if (currentMouseState.MiddleButton == ButtonState.Pressed && previousMouseState.MiddleButton == ButtonState.Pressed)
            {
                camOffset.X += (previousMouseState.X - currentMouseState.X) / 100.0f;
                camOffset.Y -= (previousMouseState.Y - currentMouseState.Y) / 100.0f;
            }

            camPosition = Vector3.Transform(new Vector3(0, 0, distance), Matrix.CreateRotationX(camAngleX) * Matrix.CreateRotationY(camAngleY));
            view = Matrix.CreateLookAt(camPosition, Vector3.Zero, Vector3.Transform(Vector3.UnitY, Matrix.CreateRotationX(camAngleX) * Matrix.CreateRotationY(camAngleY)));

            previousKeyState = Keyboard.GetState();
            previousMouseState = Mouse.GetState();
            lightPosition = Vector3.Transform(new Vector3(0, 0, 1), Matrix.CreateRotationX(MathHelper.ToRadians(lightX)) * Matrix.CreateRotationY(MathHelper.ToRadians(lightY)));
            base.Update(gameTime);
        }


        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);
            GraphicsDevice.DepthStencilState = new DepthStencilState();
            RasterizerState originalRasterizerState =
              graphics.GraphicsDevice.RasterizerState;
            RasterizerState rasterizerState = new RasterizerState();
            rasterizerState.CullMode = CullMode.None;
            graphics.GraphicsDevice.RasterizerState = rasterizerState;
            skybox.Draw(view, projection, camPosition);
            graphics.GraphicsDevice.RasterizerState = originalRasterizerState;

            DrawModelWithEffect();
            spriteBatch.Begin();
            if (showMenu) showHelp();
            if (showValues) showInfo();
            spriteBatch.End();

            base.Draw(gameTime);
        }
        private void DrawModelWithEffect()
        {
            effect.CurrentTechnique = effect.Techniques[0];

            foreach (EffectPass pass in effect.CurrentTechnique.Passes)
            {
                foreach (ModelMesh mesh in model.Meshes)
                {
                    foreach (ModelMeshPart part in mesh.MeshParts)
                    {
                        effect.Parameters["World"].SetValue(mesh.ParentBone.Transform);
                        effect.Parameters["View"].SetValue(view);
                        effect.Parameters["Projection"].SetValue(projection);
                        effect.Parameters["CameraPosition"].SetValue(camPosition);
                        Matrix worldInverseTransposeMatrix = Matrix.Transpose(Matrix.Invert(mesh.ParentBone.Transform));
                        effect.Parameters["WorldInverseTranspose"].SetValue(worldInverseTransposeMatrix);
                        effect.Parameters["lightPosition"].SetValue(lightPosition);
                        effect.Parameters["distance"].SetValue(waveDistance);
                        effect.Parameters["roughness"].SetValue(roughness);
                        effect.Parameters["hiLiteColor"].SetValue(hilightColor);
                        effect.Parameters["environmentMap"].SetValue(skybox.skyBoxTexture);

                        pass.Apply();
                        GraphicsDevice.SetVertexBuffer(part.VertexBuffer);
                        GraphicsDevice.Indices = part.IndexBuffer;

                        GraphicsDevice.DrawIndexedPrimitives(
                             PrimitiveType.TriangleList, part.VertexOffset, part.StartIndex, part.PrimitiveCount);
                    }
                }
            }
        }

        private void showHelp()
        {
            int i = 0;
            spriteBatch.DrawString(font, "Type 1,2,3,4,5: Model Change", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Type H Key: Display Parameters", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Type ? Key: Help Menu", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Mouse: Views", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Type d/D: Wavelength Distance", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Type a/A: Roughness", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Type 6/7/8/9: Hilite Color R/G/B/A", Vector2.UnitX * 575 + Vector2.UnitY * 15 * (i++), Color.White);

        }
        private void showInfo()
        {
            int i = 0;
            spriteBatch.DrawString(font, "Hilight Color: " + hilightColor, Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Roughness: " + roughness, Vector2.UnitY * 15 * (i++), Color.White);
            spriteBatch.DrawString(font, "Wave Length Distance: " + waveDistance, Vector2.UnitY * 15 * (i++), Color.White);
        }

    }
}
