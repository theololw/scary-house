extends CharacterBody2D

var target = null
var SPEED = 150
var invincible = false

var life = 100
var half = false
func _ready():
	$half.play("normal")

func _process(delta):
	$ProgressBar.value = life
	
	if life < 50:
		half = true
		$half.play("half")
		SPEED = 50
	
	if life < 1:
		Global.enemies_left -= 1
		dead()
	
		life = 10
		
	
	if target: # look after player
		$AnimationPlayer.play("walk")
		var velocity = global_position.direction_to(target.global_position) # move towards the player
		move_and_collide(velocity * SPEED * delta) # add forces to body
		if target.position.x < position.x:
			$Zombie.flip_h = true
		else:
			$Zombie.flip_h = false
	else:
		$AnimationPlayer.play("idle")

func _on_projectile_collision_area_entered(area):
	life -= 2
	


func _on_vision_body_entered(body):
	if body.name == "player":
		target = body

func _on_vision_body_exited(body):
	if body.name == "player":
		target = null

func dead():
	queue_free()

