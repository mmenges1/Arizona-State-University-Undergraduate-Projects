using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerBoardManager : MonoBehaviour {
	public static GameObject[,] playerBoard;

	// Use this for initialization
/*	void Start () {
		playerBoard = new GameObject[10,10];
		int indexOfBoard = 0;

		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				playerBoard[i,j] = (GameObject)Instantiate (gridPoint, new Vector3 ((float)i, 0, (float)j), Quaternion.identity);
				playerBoard[i,j].transform.parent = transform;
				playerBoard[i,j].transform.name = "gridPoint" + indexOfBoard;
				playerBoard[i,j].transform.position += new Vector3 ((float)-4.0, (float)2.0, (float)6.0);
				playerBoard[i,j].SetActive (true);
				indexOfBoard++;
			}
		}
	}*/
	
	// Update is called once per frame
	void Update () {
		
	}
}
