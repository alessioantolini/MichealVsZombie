extends Actor

var animation_state_machine
var flipped: = false

func _ready():
	animation_state_machine = $micheal/AnimationTree.get("parameters/playback")

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
	animation_state_machine.travel("idle")
	#$SpriteNinja/AnimationPlayer.play("idle")

func set_animation_run():
	animation_state_machine.travel("run")

func set_animation_jump():
	animation_state_machine.travel("jump")

func set_animation_attack():
	animation_state_machine.travel("attack")

func set_animation_jump_attack():
	animation_state_machine.travel("jump_attack")
