#pragma strict

var rows : int;
var columns : int;

var gridSize : Vector3;
var gridOffset : Vector3;

var cellSprite : GameObject;

function Start () {
	initializeCells();
}

function Update () {
	
}

function initializeCells ()
{
	var cellObject = new GameObject();

	var newCellSize : Vector3;
	var cellSize : Vector3;
	var cellScale : Vector3;

	//cellObject.AddComponent(SpriteRenderer).sprite = cellSprite;
	cellSize = cellSprite.transform.localScale;

	newCellSize.x = (gridSize.x / columns);
	newCellSize.z = (gridSize.z / rows);

	cellScale.x = newCellSize.x / cellSize.x;
	cellScale.z = newCellSize.z / cellSize.x;

	cellSize = newCellSize;

	cellObject.transform.localScale = new Vector2(cellScale.x, cellScale.z);

	gridOffset.x = -(gridSize.x / 2) + cellSize.x / 2;
	gridOffset.z = -(gridSize.z / 2) + cellSize.z / 2;
	for (var row = 0; row < rows; row++)
	{
		for (var col = 0; col < columns; col++)
		{
			var pos = new Vector3(col * cellSize.x + gridOffset.x + transform.position.x, row * cellSize.z + gridOffset.z + transform.position.z);
			var copy = Instantiate(cellObject, pos, Quaternion.identity ) as GameObject;
			copy.transform.parent = transform;
		}
	}
	cellObject.transform.localRotation = Quaternion.identity;
	Destroy(cellObject);
}
