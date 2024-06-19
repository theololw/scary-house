extends CharacterBody2D

var target = null
const SPEED = 175

var life = 100

func _physics_process(delta):
	$ProgressBar.value = life
	
	if life < 1:
		Global.enemies_left -= 1
		dead()
	
	
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * SPEED * delta)
		$Ghost.frame = 1
		$glow.color = Color(1,0,0)
		if target.position.x < position.x:
			$Ghost.flip_h = false
		else:
			$Ghost.flip_h = true
	else:
		$Ghost.frame = 0
		$glow.color = Color(1,1,1)
	

func _on_vision_body_entered(body):
	if body.name == "player":
		target = body
func _on_vision_body_exited(body):
	if body.name == "player":
		target = null


func _on_projectile_collision_area_entered(area):
	life -= 0.5

func dead():
	queue_free()
