using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class enemyManager : MonoBehaviour {
	public GameObject gridPoint;
	public static GameObject[,] enemyBoard;
	public static int enemyShips = 5;
	Ship ship1;
	Ship ship2;
	Ship ship3;
	Ship ship4;
	Ship ship5;

	public static int health1 = 2; //ship5
	public static int health2 = 3; //ship1
	public static int health3 = 3; //ship2
	public static int health4 = 4; //ship3
	public static int health5 = 5; //ship4

	private string shootName;
	public static bool flag = false;
	public static enemyManager instance = null;

	public Material inactive = null;
	public Material active = null;
	public Material miss = null;
	public Material hit = null;

	public GameObject battleShip1;
	public GameObject battleShip2;
	public GameObject battleShip3;
	public GameObject battleShip4;
	public GameObject battleShip5;


	void Awake() {
		if (instance == null)
			instance = this;
		else if (instance != this)
			Destroy(gameObject);

		DontDestroyOnLoad (gameObject);
		InitGame ();
	}

	// Use this for initialization
	void InitGame () {
		int index = 0;
		enemyBoard = new GameObject[10,10];

			for (int i = 0; i < 10; i++)
			{
				for (int j = 0; j < 10; j++)
				{
					enemyBoard[i,j] = (GameObject)Instantiate (gridPoint, new Vector3 ((float)i, 0, (float)j), Quaternion.identity);
					enemyBoard[i, j].transform.parent = transform;
					enemyBoard [i, j].name = "gridPoint" + index;
					enemyBoard[i, j].transform.position += new Vector3 ((float)-4.0, (float)2.0, (float)6.0);
					enemyBoard [i, j].GetComponent<ParticleSystem> ().Pause ();
					index++;

					//place ships
					if (i == 1) {
						if (j == 1) {
							ship1 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship1;
							enemyBoard [i, j].tag = "Eship1-1";
							ship1.setHealth (3);
							ship1.setShipNum (2);
						}
						if (j == 2) {
							ship1 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship1;
							enemyBoard [i, j].tag = "Eship1-2";
						}
						if (j == 3) {
							ship1 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship1;
							enemyBoard [i, j].tag = "Eship1-3";
						}
					}
					if (i == 8) {
						if (j == 3) {
							ship3 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship3;
							enemyBoard [i, j].tag = "Eship3-1";
							ship3.setHealth (4);
							ship3.setShipNum (4);
						}
						if (j == 4) {
							ship3 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship3;
							enemyBoard [i, j].tag = "Eship3-2";
						}
						if (j == 5) {
							ship3 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship3;
							enemyBoard [i, j].tag = "Eship3-3";
						}
						if (j == 6) {
							ship3 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship3;
							enemyBoard [i, j].tag = "Eship3-4";
						}
					}
					if (j == 5) {
						if (i == 3) {
							ship2 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship2;
							enemyBoard [i, j].tag = "Eship2-1";
							ship2.setHealth (3);
							ship2.setShipNum (3);
						}
						if (i == 4) {
							ship2 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship2;
							enemyBoard [i, j].tag = "Eship2-2";
						}
						if (i == 5) {
							ship2 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship2;
							enemyBoard [i, j].tag = "Eship2-3";
						}
					}
					if (j == 8) {
						if (i == 5) {
							ship4 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship4;
							enemyBoard [i, j].tag = "Eship4-1";
							ship4.setHealth (5);
							ship4.setShipNum (5);
						}
						if (i == 6) {
							ship4 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship4;
							enemyBoard [i, j].tag = "Eship4-2";
						}
						if (i == 7) {
							ship4 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship4;
							enemyBoard [i, j].tag = "Eship4-3";
						}
						if (i == 8) {
							ship4 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship4;
							enemyBoard [i, j].tag = "Eship4-4";
						}
						if (i == 9) {
							ship4 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship4;
							enemyBoard [i, j].tag = "Eship4-5";
						}
					}
					if (j == 9) {
						if (i == 2) {
							ship5 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship5;
							enemyBoard [i, j].tag = "Eship5-1";
							ship5.setHealth (2);
							ship5.setShipNum (1);
						}
						if (i == 3) {
							ship5 = enemyBoard [i, j].AddComponent<Ship> () as Ship;
							//enemyBoard[i,j].GetComponents<Ship> = ship5;
							enemyBoard [i, j].tag = "Eship5-2";
						}
					}
				}
			}
			
	}
	
	// Update is called once per frame
	// render misses and hits
	void Update () {
		if (enemyShips == 0) {
			//go to gameOver scene
			Debug.Log("Player win");
			Destroy(gameObject.transform.parent.transform.parent);
			Application.LoadLevel("GameOver");
		}
		if (health1 <= 0) {
			this.battleShip1.SetActive(true);
		}
		if (health2 <= 0) {
			this.battleShip2.SetActive(true);
		}
		if (health3 <= 0) {
			this.battleShip3.SetActive(true);
		}
		if (health4 <= 0) {
			this.battleShip4.SetActive(true);
		}
		if (health5 <= 0) {
			this.battleShip5.SetActive(true);
		}
	}
		
	bool isShipHit(GameObject selection) {
		for (int i = 0; i < 10; i++) {
			for (int j = 0; j < 10; j++) {
				//find specific ship
				if (selection.tag.CompareTo(enemyBoard[i,j].tag) == 0) {
					if (selection.tag.Contains("Eship1")) {
						health2--;
					}
					if (selection.tag.Contains("Eship2")) {
						health3--;
					}
					if (selection.tag.Contains("Eship3")) {
						health4--;
					}
					if (selection.tag.Contains("Eship4")) {
						health5--;
					}
					if (selection.tag.Contains("Eship5")) {
						health1--;
					}
					enemyBoard[i, j].tag = "hit";
					enemyBoard[i, j].GetComponent<Ship> ().takeDamage ();
					enemyBoard[i, j].GetComponent<ParticleSystem> ().Play ();
					enemyBoard[i,j].GetComponent<Renderer>().material = hit;
					isShipSunk (enemyBoard [i, j].GetComponent<Ship>());
					var shipComponent = enemyBoard [i, j].GetComponent<Ship> ();
					Destroy (shipComponent);
					return true;
				}
			}
		}
		return false;
	}

	void isShipSunk(Ship ship) {
		Debug.Log (enemyShips);
		if (health1 == 0) {
			enemyShips--;
			health1 = -1;
			Debug.Log ("One less ship");
		}
		if (health2 == 0) {
			enemyShips--;
			health2 = -1;
			Debug.Log ("One less ship");
		}
		if (health3 == 0) {
			enemyShips--;
			health3 = -1;
			Debug.Log ("One less ship");
		}
		if (health4 == 0) {
			enemyShips--;
			health4 = -1;
			Debug.Log ("One less ship");
		}
		if (health5 == 0) {
			enemyShips--;
			health5 = -1;
			Debug.Log ("One less ship");
		}
		Debug.Log (enemyShips);
	}

	// function for button, check if ship is sunk
	// if no hit, make "Miss!" appear and OK button to move to playerBoard scene
	// if all ships are sunk go to gameOver scene
	public void shoot() {
		// check if target is a ship
		if (PlayerShoot.targetedShip.tag.StartsWith("Eship")) {
			if (isShipHit (PlayerShoot.targetedShip)) {
				flag = false;
				Debug.Log (PlayerShoot.targetedShip.name);
			}
		} else {
			//pop up "Miss!"
			flag = false;
			PlayerShoot.targetedShip.tag = "miss";
			Debug.Log("Miss!");
			PlayerShoot.targetedShip.GetComponent<Renderer>().material = miss;
			//Application.DontDestroyOnLoad(Application.);
			//Application.DontDestroyOnLoad (notLoaded2);
			Application.LoadLevel ("playerBoard");
		}

	}
}



public class Ship : MonoBehaviour {
	public int health = 0;
	public bool isDead = false;
	public int shipNum = 0;

	public void setShipNum(int num) {
		shipNum = num;
	}

	public void setHealth(int size) {
		health = size;
	}

	public void takeDamage() {
		health--;
	}

	public bool isSunk() {
		if (health <= 0) {
			return true;
		} else
			return false;
	}
}
