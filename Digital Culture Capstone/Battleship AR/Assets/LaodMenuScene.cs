using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LaodMenuScene : MonoBehaviour {

	public void LoadMenuScene()
	{
		Application.LoadLevel("Menu");
	}
	public void LoadGameScene()
	{
		Application.LoadLevel("placeShips");
	}
}
