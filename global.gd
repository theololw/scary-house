extends Node


var enemies_left = 20
var gamemode = "Start" # choose gamemode. "Human", "Vampire", "Zombie", "Ghost", "Deer"S
var gamemodeNumber = -1

func _process(delta):
	if gamemodeNumber == -1:
		gamemode = "Start"
	if gamemodeNumber == 0:
		gamemode = "Human"
	if gamemodeNumber == 1:
		gamemode = "Vampire"
	if gamemodeNumber == 2:
		gamemode = "Zombie"
	if gamemodeNumber == 3:
		gamemode = "Ghost"
	if gamemodeNumber == 4:
		gamemode = "Deer"
