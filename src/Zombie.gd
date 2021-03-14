extends Actor


var flipped: = false

#func _ready():

func move_actor():
	flipped=set_animation_dir(flipped)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	):
	var new_velocity: = linear_velocity
	
	#Imposta accelerazione
	new_velocity.x = min(abs(new_velocity.x)+acceleration,speed.x) * direction.x
	
	#Gravità
	new_velocity.y += gravity*get_physics_process_delta_time()
	
	#Salto
	if direction.y == -1.0:
		 new_velocity.y = direction.y * speed.y
	
	
	velocity = new_velocity


func set_animation_dir(isFlipped: bool) -> bool:
	var flip: = isFlipped
	if((direction.x>0)&&flip):
		apply_scale(Vector2(-1, 1)) # flip
		flip=false
	elif ((direction.x<0)&&!flip):
		apply_scale(Vector2(-1, 1)) # flip
		flip=true
	return flip

func set_animation_idle():
	$Zombie.play("idle")
	#animation_state_machine.travel("idle")
	#$SpriteNinja/AnimationPlayer.play("idle")

func set_animation_run():
	$Zombie.play("running")

func set_animation_attack():
	$Zombie.play("attack")
	

func set_animation_dead():
	$Zombie.play("dead")
