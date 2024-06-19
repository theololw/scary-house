extends Node2D

var door_opened = false

func open_door():
	if door_opened == false:
		$AnimationPlayer.play("open")
		door_opened = true
