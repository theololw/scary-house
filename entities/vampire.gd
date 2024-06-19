extends CharacterBody2D

var target = null
const SPEED = 100
var invincible = false

var life = 50
var in_poison = false

func _process(delta):
	if in_poison == true: # check if in poison
		life -= 40 * delta # remove 0.5 life every frame
	$ProgressBar.value = life # display life on progressbar
	
	if life < 1:
		Global.enemies_left -= 1
		dead()
	
	if target: # look after player
		var velocity = global_position.direction_to(target.global_position) # move towards the player
		move_and_collide(velocity * SPEED * delta) # add forces to body
		
		if target.position.x < position.x: # look at player
			$Vampire.flip_h = true
		else:
			$Vampire.flip_h = false

func _on_projectile_collision_area_entered(area):
	if area.name == "Area_of_effect":
		in_poison = true

func _on_projectile_collision_area_exited(area):
	if area.name == "Area_of_effect":
		in_poison = false


func _on_vision_body_entered(body):
	if body.name == "player":
		target = body

func _on_vision_body_exited(body):
	if body.name == "player":
		target = null
func dead():
	queue_free()


		
