using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyBehaviour : MonoBehaviour {
	public Material inactive = null;
	public Material active = null;
	public Material miss = null;
	public Material hit = null;

	public int i;
	public int j;
	bool horizontalSearch = true;

	bool searching = false;

	// Use this for initialization
	void Start () {
		i = (int) Random.Range (0, 9);
		j = (int) Random.Range (0, 9);

		if (gameManager.playerShips > 0) {
			//Check if the spot has not already been hit
			Debug.Log ("Ships left");
			Debug.Log (i);
			Debug.Log (j);
			Debug.Log (gameManager.playerBoard [i, j].tag);
			if (gameManager.playerBoard[i, j].tag.CompareTo("Inactive") == 0 && !(gameManager.playerBoard[i, j].tag.Contains("miss")) && !(gameManager.playerBoard[i, j].tag.Contains("hit")) ) {
				//This will result in a miss
				//Move to enemyBoard scene
				Debug.Log ("AI miss");
				gameManager.playerBoard [i, j].tag = "miss";
				gameManager.playerBoard[i,j].GetComponent<Renderer> ().material = miss;
				searching = false;
			} else if (gameManager.playerBoard[i, j].tag.StartsWith("Ship") && !(gameManager.playerBoard[i, j].tag.Contains("miss")) && !(gameManager.playerBoard[i, j].tag.Contains("hit")) ) {
				// This will be a hit
				Debug.Log ("AI hit");
				gameManager.playerBoard [i, j].tag = "hit";
				gameManager.playerBoard[i,j].GetComponent<Ship>().takeDamage ();
				gameManager.playerBoard[i,j].GetComponent<Renderer>().material = hit;
				searching = true;
				if (gameManager.playerBoard[i,j].GetComponent<Ship>().isSunk ()) {
					gameManager.playerShips--;
					// change i and j
					i = (int) Random.Range (0, 9);
					j = (int) Random.Range (0, 9);
					horizontalSearch = false;
				} else {
					Debug.Log ("New Search");
					//look for adjacent
					if (horizontalSearch) {
						int leftOrRight = (int)Random.Range (0, 1);
						if (i == 9) {
							i--;
						} else if (i == 0) {
							i++;
						} else if (leftOrRight > 0) { // search to the right 
							i++;
						} else {
							i--;
						}
					} else {
						int upOrDown = (int)Random.Range (0, 1);
						if (j == 9) {
							j--;
						} else if (j == 0) {
							j++;
						} else if (upOrDown > 0) { // search up 
							j++;
						} else {
							j--;
						}
					}
				}
			}
		} else { // if no ships left
			searching = false;
			Debug.Log ("AI win");
			Application.LoadLevel ("GameOver");
		}
	}
	
	// Update is called once per frame
	void Update () {
		// Guess a target 

		while (searching) {
			if (gameManager.playerShips != 0) {
				//Check if the spot has not already been hit
				i = (int) Random.Range (0, 9);
				j = (int) Random.Range (0, 9);
				Debug.Log ("Ships left");
				Debug.Log (i);
				Debug.Log (j);
				if (gameManager.playerBoard [i, j].tag.CompareTo("Inactive") == 0 ) {
					//This will result in a miss
					//Move to enemyBoard scene
					Debug.Log ("AI miss");
					gameManager.playerBoard [i, j].tag = "miss";
					gameManager.playerBoard[i,j].GetComponent<Renderer> ().material = miss;
					searching = false;
				} else if (gameManager.playerBoard [i, j].tag.StartsWith("Ship")) {
					// This will be a hit
					Debug.Log ("AI hit");
					gameManager.playerBoard[i,j].GetComponent<Ship>().takeDamage ();
					gameManager.playerBoard [i, j].tag = "hit";
					gameManager.playerBoard[i,j].GetComponent<Renderer>().material = hit;
					if (gameManager.playerBoard[i,j].GetComponent<Ship>().isSunk ()) {
						gameManager.playerShips--;
						// change i and j
						i = (int) Random.Range (0, 9);
						j = (int) Random.Range (0, 9);
						horizontalSearch = false;
					} else {
						//look for adjacent
						if (horizontalSearch) {
							int leftOrRight = (int)Random.Range (0, 1);
							if (i == 9) {
								i--;
							} else if (i == 0) {
								i++;
							} else if (leftOrRight > 0) { // search to the right 
								i++;
							} else {
								i--;
							}
						} else {
							int upOrDown = (int)Random.Range (0, 1);
							if (j == 9) {
								j--;
							} else if (j == 0) {
								j++;
							} else if (upOrDown > 0) { // search up 
								j++;
							} else {
								j--;
							}
						}
					}
				}
			} else {
				searching = false;
				Debug.Log ("AI win");
				Application.LoadLevel ("GameOver");
			}
		}

		//Application.LoadLevel ("enemyBoard");
	}

	public void moveOn() {
		Application.LoadLevel ("enemyBoard");
	}
}
