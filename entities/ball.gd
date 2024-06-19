extends StaticBody2D

var x_velocity = 7.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += x_velocity


func _on_wall_collision_body_entered(body):
	x_velocity *= -1
	$AnimationPlayer.speed_scale *= -1
