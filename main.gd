extends Node2D

var enemyPositions = []

var zombie_scene = load("res://entities/zombie.tscn")
var ghost_scene = load("res://entities/ghost.tscn")
var deer_scene = load("res://entities/deer.tscn")

func _ready():
	Global.enemies_left = 20
	$hidden_walls/trap.play("close")
	
	if Global.gamemode == "Vampire":
		var enemies = get_tree().get_nodes_in_group("enemies")
		for enemy in enemies:
			var enemy_position = enemy.position
			var zombie_scene_instance = zombie_scene.instantiate()
			zombie_scene_instance.position = enemy_position
			add_child(zombie_scene_instance)
			enemy.queue_free()
	
	if Global.gamemode == "Zombie":
		var enemies = get_tree().get_nodes_in_group("enemies")
		for enemy in enemies:
			var enemy_position = enemy.position
			var ghost_scene_instance = ghost_scene.instantiate()
			ghost_scene_instance.position = enemy_position
			add_child(ghost_scene_instance)
			enemy.queue_free()
	
	if Global.gamemode == "Ghost":
		var enemies = get_tree().get_nodes_in_group("enemies")
		for enemy in enemies:
			var enemy_position = enemy.position
			var deer_scene_instance = deer_scene.instantiate()
			deer_scene_instance.position = enemy_position
			add_child(deer_scene_instance)
			enemy.queue_free()

func _process(delta):
	if Global.enemies_left == 19:
		$doors/door1.open_door()
	if Global.enemies_left == 16:
		$doors/door2.open_door()
		$doors/door3.open_door()
	if Global.enemies_left == 12:
		$doors/door4.open_door()
	if Global.enemies_left == 10:
		$doors/door5.open_door()
	if Global.enemies_left == 6:
		$doors/door6.open_door()
		$doors/door7.open_door()
	if Global.enemies_left == 0:
		$doors/door8.open_door()


func _on_trip_wire_body_entered(body):
	$hidden_walls/trap.play("open")


func _on_end_zone_body_entered(body):
	if Global.gamemode == "Human":
		$endZone/AnimationPlayer.play("Human_ending")
	if Global.gamemode == "Vampire":
		$endZone/AnimationPlayer.play("Vampire_ending")
	if Global.gamemode == "Zombie":
		$endZone/AnimationPlayer.play("Zombie_ending")
	if Global.gamemode == "Ghost":
		$endZone/AnimationPlayer.play("Ghost_ending")
	


func _on_animation_player_animation_finished(anim_name):
	Global.gamemodeNumber += 1
	get_tree().change_scene_to_file("res://cutscenes.tscn")
