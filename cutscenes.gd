extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.gamemode == "Start":
		$AnimationPlayer.play("humanVsVampire")
		Global.gamemode = "Human"
		Global.gamemodeNumber = 0
		
	elif Global.gamemode == "Human":
		$AnimationPlayer.play("VampireVsZombie")
		
	
	elif Global.gamemode == "Vampire":
		$AnimationPlayer.play("ZombieVsGhost")
		
	
	elif Global.gamemode == "Zombie":
		$AnimationPlayer.play("GhostVsDeer")
		
	
	elif Global.gamemode == "Ghost":
		$AnimationPlayer.play("Ending")
	
	


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://main.tscn")
	
