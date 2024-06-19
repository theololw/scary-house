extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Vector2(0,1)
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	if position.y < -32:
		position.y = 28
