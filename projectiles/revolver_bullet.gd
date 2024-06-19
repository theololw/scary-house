extends Area2D

var speed = 1200


func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))  # Calculate the direction from the rotation
	position += direction * speed * delta


func _on_body_entered(body):
	hide()
	queue_free()
