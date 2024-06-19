extends RigidBody2D

var speed = 500.0
var velocity = Vector2.ZERO

func _ready():
	await get_tree().create_timer(0.01).timeout
	$woosh1.play()
	var local_forward: Vector2 = Vector2.RIGHT
	
	# Convert local forward direction to global direction
	var global_forward: Vector2 = global_transform.basis_xform(local_forward)
	
	# Apply the linear velocity
	linear_velocity = global_forward * speed

	angular_velocity = 45
	$garlic_timer.start()
	
func _on_garlic_timer_timeout():
	detonate()
func _on_detonate_collision_body_entered(body):
	detonate()

func detonate():
	if find_child("detonate_collision"): # delete the collision handling detonation
		$detonate_collision.queue_free()
	
	$Garlic.hide() # hide the garlic sprite
	$smoke.emitting = true # activate garlic particles
	linear_velocity = Vector2(0,0) # stop velocity so the particles dont move
	angular_velocity = 0 # stop spinning so the particles dont spin
	
	$AnimationPlayer.play("collisionOn") # make area of effect enabled
	await get_tree().create_timer(1).timeout # wait two seconds
	$smoke.emitting = false # stop emitting particles
	if find_child("Area_of_effect"): # delete area of effect
		$Area_of_effect.queue_free()
	await get_tree().create_timer(1).timeout # wait one second
	queue_free() # delete the entire scene


