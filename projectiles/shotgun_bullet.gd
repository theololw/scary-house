extends Area2D

var speed = 800

func _ready():
	$bullet_duration.start()
	randomize()  # Ensure randomness
	speed = randi_range(1200,1600)
	var angle_offset = randf_range(-30, 30)  # Random angle between -22.5 and 22.5 degrees
	rotation += deg_to_rad(angle_offset)  # Adjust the rotation by the random angle

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))  # Calculate the direction from the rotation
	position += direction * speed * delta
	


func _on_bullet_duration_timeout():
	queue_free()


func _on_body_entered(body):
	hide()
	queue_free()

