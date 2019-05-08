using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class EnemyLoader : MonoBehaviour {
	//public static GameObject EnemyManager;
	//public static GameObject GameManager;
	//public GameObject ImageTarget;


	// Use this for initialization
	void Awake () {
		Loader.GameManager.transform.GetChild (0).GetChild (0).gameObject.SetActive (false);
			if (enemyManager.instance == null) {
				Debug.Log ("Made Enemy Manager");
				Loader.EnemyManager = (GameObject)Instantiate(Resources.Load("EnemyGameManager"));
				Loader.EnemyManager.SetActive (true);
			} else {
				Loader.GameManager.transform.GetChild (0).GetChild (1).gameObject.SetActive (true);
			}
	}

	// Update is called once per frame
	void Update()
	{

	}
}
