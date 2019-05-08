#pragma strict

var levelToLoad : String;

function Start(){
}

function LoadLevel() {
Application.LoadLevel(levelToLoad);
}

function QuitApp() {
Application.Quit();
}
