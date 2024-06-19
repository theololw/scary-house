extends Node2D

var speed = 300  # Initial speed
var slowdown_rate = 0.95  # Slowdown factor applied each frame

func _ready():
	$decay_cooldown.start()
	speed = randi_range(300,600)
	randomize()  # Ensure randomness
	var angle_offset = randf_range(-40, 40)  # Random angle between -22.5 and 22.5 degrees
	rotation += deg_to_rad(angle_offset)  # Adjust the rotation by the random angle

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))  # Calculate the direction from the rotation
	position += direction * speed * delta
	
	# Slow down the bullet
	speed *= slowdown_rate


func _on_body_entered(body):
	queue_free()


func _on_decay_cooldown_timeout():
	queue_free()
