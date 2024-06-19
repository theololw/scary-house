extends CharacterBody2D

@export var speed = 500
@onready var flashlight = $flashlight
@onready var camera = $Camera2D
@onready var weapon_cooldown = $weapon_cooldown
var life = 3

var garlic_bomb = load("res://projectiles/garlic_bomb.tscn")
var shotgun_bullet = load("res://projectiles/shotgun_bullet.tscn")
var salt = load("res://projectiles/salt.tscn")
var revolver_bullet = load("res://projectiles/revolver_bullet.tscn")


var invincible = false
var weapon_ready = true
var weapon_timer_active = false

func _process(delta):
	if weapon_ready == false and weapon_timer_active == false:
		weapon_cooldown.start()
		weapon_timer_active = true
	if weapon_ready == true:
		$CanvasLayer/weapon_ready.show()
	else:
		$CanvasLayer/weapon_ready.hide()
	# movement
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	move_and_slide()
	
	#flashlight position
	flashlight.position = get_local_mouse_position()
	
	camera.offset = get_local_mouse_position() / 5 # camera controls
	
	# look at mouse position
	if get_global_mouse_position().x > position.x:
		$Sprites.scale = Vector2(1,1)
		$hand/weapon.scale = Vector2(1,1)
	else:
		$Sprites.scale = Vector2(-1,1)
		$hand/weapon.scale = Vector2(-1,1)
	
	$hand.look_at(get_global_mouse_position()) # make weapon look at mouse direction
	
	if Global.gamemode == "Human":
		HumanMode()
	if Global.gamemode == "Vampire":
		VampireMode()
	if Global.gamemode == "Zombie":
		ZombieMode()
	if Global.gamemode == "Ghost":
		GhostMode()

func HumanMode():
	$Sprites/spritesPlayer.play("human")
	if Input.is_action_pressed("shoot") and weapon_ready == true:
		weapon_ready = false
		var garlic_bomb_instance = garlic_bomb.instantiate()
		garlic_bomb_instance.position = $hand/weapon.global_position
		garlic_bomb_instance.rotation = $hand.rotation
		get_parent().add_child(garlic_bomb_instance)
		

func VampireMode():
	$Sprites/spritesPlayer.play("vampire")
	if Input.is_action_pressed("shoot") and weapon_ready == true:
		weapon_ready = false
		$hand/weapon/Shotgun/muzzel/explosion.play()
		for i in range(30):
			var shotgun_bullet_instance = shotgun_bullet.instantiate()
			shotgun_bullet_instance.position = $hand/weapon/Shotgun/muzzel.global_position
			shotgun_bullet_instance.rotation = $hand.rotation
			get_parent().add_child(shotgun_bullet_instance)

func ZombieMode():
	$Sprites/spritesPlayer.play("zombie")
	if Input.is_action_pressed("shoot") and weapon_ready == true:
		weapon_ready = false
		$hand/weapon/Salt/AudioStreamPlayer.play()
		for i in range(100):
			var salt_instance = salt.instantiate()
			salt_instance.position = $hand/weapon/Salt/muzzel.global_position
			salt_instance.rotation = $hand.rotation
			get_parent().add_child(salt_instance)

func GhostMode():
	$Sprites/spritesPlayer.play("ghost")
	if Input.is_action_pressed("shoot") and weapon_ready == true:
		weapon_ready = false
		$hand/weapon/revolver/AudioStreamPlayer.play()
		for i in range(1):
			var bullet_instance = revolver_bullet.instantiate()
			bullet_instance.position = $hand/weapon/revolver/muzzel.global_position
			bullet_instance.rotation = $hand.rotation
			get_parent().add_child(bullet_instance)

func _on_weapon_cooldown_timeout():
	weapon_ready = true
	weapon_timer_active = false
func _on_enemy_collision_body_entered(body):
	$hurt.play()
	if invincible == false:
		invincible = true
		life -= 1
		$CanvasLayer/health.text = str(life)
		hide()
		await get_tree().create_timer(0.1).timeout
		show()
		await get_tree().create_timer(0.1).timeout
		hide()
		await get_tree().create_timer(0.1).timeout
		show()
		await get_tree().create_timer(0.1).timeout
		hide()
		await get_tree().create_timer(0.1).timeout
		show()
		invincible = false
		if life < 1:
			get_tree().change_scene_to_file("res://died.tscn")
