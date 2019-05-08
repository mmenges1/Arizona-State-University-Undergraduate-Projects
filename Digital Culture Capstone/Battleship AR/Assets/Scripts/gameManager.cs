using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class gameManager : MonoBehaviour {
	public GameObject gridPoint;
	public static GameObject[,] playerBoard;
	public static int playerShips = 5;
	public static int shipIndex;
	public static bool flag = false;
	public string level;
	public static gameManager instance = null;

	public static Ship ship1;
	public static Ship ship2;
	public static Ship ship3;
	public static Ship ship4;
	public static Ship ship5;

	public static GameObject battleship1;
	public static GameObject battleship2;
	public static GameObject battleship3;
	public static GameObject battleship4;
	public static GameObject battleship5;

	public static Transform shipTransform1;
	public static Transform shipTransform2;
	public static Transform shipTransform3;
	public static Transform shipTransform4;
	public static Transform shipTransform5;

	public static int Ship1 = 0;
	public static int Ship2 = 0;
	public static int Ship3 = 0;
	public static int Ship4 = 0;
	public static int Ship5 = 0;

	public static int ship1Dir = 0;
	public static int ship2Dir = 0;
	public static int ship3Dir = 0;
	public static int ship4Dir = 0;
	public static int ship5Dir = 0;

	public struct coord {
		public int i;
		public int j;

		public coord(int i, int j) {
			this.i = i;
			this.j = j;
		}
	};

	public static coord[] ship1array = new coord[] { new coord() {i = -1, j = -1}, new coord() {i = -1, j = -1} };
	public static coord[] ship2array = new coord[] { new coord() {i = -1, j = -1}, new coord() {i = -1, j = -1} };
	public static coord[] ship3array = new coord[] { new coord() {i = -1, j = -1}, new coord() {i = -1, j = -1} };
	public static coord[] ship4array = new coord[] { new coord() {i = -1, j = -1}, new coord() {i = -1, j = -1} };
	public static coord[] ship5array = new coord[] { new coord() {i = -1, j = -1}, new coord() {i = -1, j = -1} };

	void Awake() {
		if (instance == null) {
			instance = this;
		} else if (instance != this) {
			Destroy (gameObject.transform.parent.transform.parent);
		}
		DontDestroyOnLoad (gameObject.transform.parent.transform.parent);
		InitGame ();
	}


	// Use this for initialization
	void InitGame() {

		//    DontDestroyOnLoad(gameManager.playerBoard);
		playerBoard = new GameObject[10,10];

		int indexOfBoard = 0;

		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				playerBoard[i,j] = (GameObject)Instantiate (gridPoint, new Vector3 ((float)i, 0, (float)j), Quaternion.identity);
				playerBoard[i,j].transform.parent = transform;
				playerBoard[i,j].transform.name = "gridPoint" + indexOfBoard;
				playerBoard [i, j].tag = "Inactive";
				playerBoard[i,j].transform.position += new Vector3 ((float)-4.0, (float)-0.8, (float)6.0);
				playerBoard[i,j].SetActive (true);
				indexOfBoard++;
			}
		}


	}

	public void DonePlacingShips()
	{
		//Application.DontDestroyOnLoad (playerBoard);
		//Application.DontDestroyOnLoad (notLoaded);
		Application.LoadLevel("enemyBoard");
	}

	public void Quit()
	{
		Application.Quit();
	}

	public void ActivateShip1Selection()
	{
		shipIndex = 1;
	}
	public void ActivateShip2Selection()
	{
		shipIndex = 2;
	}
	public void ActivateShip3Selection()
	{
		shipIndex = 3;
	}
	public void ActivateShip4Selection()
	{
		shipIndex = 4;
	}
	public void ActivateShip5Selection()
	{
		shipIndex = 5;
	}

	// Update is called once per frame
	void Update () {

	}


} 