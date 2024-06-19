extends CharacterBody2D

var target = null
var  SPEED = 100

var charge_ready = true
var life = 100

func _physics_process(delta):
	$ProgressBar.value = life
	
	if life < 1:
		Global.enemies_left -= 1
		dead()
	
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * SPEED * delta)
		if target.position.x < position.x:
			$Deer.flip_h = false
		else:
			$Deer.flip_h = true

func _on_vision_body_entered(body):
	if body.name == "player":
		target = body
func _on_vision_body_exited(body):
	if body.name == "player":
		target = null


func _on_projectile_collision_area_entered(_area):
	life -= 25

func dead():
	queue_free()

func _on_charge_cooldown_timeout():
	if target:
		$AnimationPlayer.play("stand_up")
		SPEED = 300
		await get_tree().create_timer(0.5).timeout
		$AnimationPlayer.play("stand_down")
		SPEED = 100
