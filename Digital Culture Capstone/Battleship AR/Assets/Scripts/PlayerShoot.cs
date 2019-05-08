using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerShoot : MonoBehaviour {

	GameObject player1 = null;
	public static GameObject targetedShip = null;

	public Material inactive = null;
	public Material active = null;
	public Material miss = null;
	public Material hit = null;

	void OnMouseDown() {
		//limit one until check?
		if ( Input.GetMouseButtonDown(0))
		{
				print(gameObject.name);
			for (int i = 0; i < 10; i++) {
				for (int j = 0; j < 10; j++) 
				{
					player1 = enemyManager.enemyBoard[i, j];
					if (gameObject.name.Equals(player1.name)) {
						if (enemyManager.flag == true) {
							if (gameObject.GetComponent<Renderer>().material.name.Contains ("active")) {
								//should set active tile to inactive and flag back to false
								enemyManager.flag = false;
								player1.GetComponent<Renderer> ().material = inactive;
							} else if (gameObject.GetComponent<Renderer>().material.name.Contains("miss"))  {
								player1.GetComponent<Renderer> ().material = miss;
							} else if (gameObject.GetComponent<Renderer>().material.name.Contains("hit"))  {
								player1.GetComponent<Renderer> ().material = hit;
							} else {
								player1.GetComponent<Renderer> ().material = inactive;
							}
						} else { // if 
							//The "inactive" material (or grid material) just needs to have the same name as this
							if (gameObject.GetComponent<Renderer>().material.name.Contains("grid")) {
								enemyManager.flag = true;
								player1.GetComponent<Renderer> ().material = active;
								targetedShip = enemyManager.enemyBoard [i, j];
							} else if (gameObject.GetComponent<Renderer>().material.name.Contains("miss")) { // if (gameObject.GetComponent<Renderer>().material.Equals(active)) 
								enemyManager.flag = false;
								player1.GetComponent<Renderer> ().material = miss;
							}
							else if (gameObject.GetComponent<Renderer>().material.name.Contains ("hit")) { // if (gameObject.GetComponent<Renderer>().material.Equals(active)) 
								enemyManager.flag = false;
								player1.GetComponent<Renderer> ().material = hit;
							}else { // if (gameObject.GetComponent<Renderer>().material.Equals(active)) 
								enemyManager.flag = false;
								player1.GetComponent<Renderer> ().material = inactive;
							}
						}
					}
				}
			}
		}
	}
}
