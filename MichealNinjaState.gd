extends StateMachine

class_name MichealNinjaState

var _attack: = 0.0

func _ready():
	add_state("idle")
	add_state("running")
	add_state("jump")
	add_state("attack")
	add_state("jump_attack")
	call_deferred("set_state",states.idle)

func get_input():
	var _direction: = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var _isJump: = -1.0 if (Input.get_action_strength("move_jump") and parent.is_on_floor()) else 1.0	
	
	#Attacco
	_attack = Input.get_action_strength("move_attack")
	
	parent.direction = Vector2 (
		_direction,
		_isJump
	)

func _state_logic(delta):
	get_input()
	parent.calculate_move_velocity(parent.velocity,parent.direction,parent.speed)
	parent.move_actor()
	return null

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if (_attack!=0): return states.jump_attack
				if parent.velocity.y!=0: return states.jump
			else:
				if (_attack!=0): return states.attack
				if parent.velocity.x!=0: return states.running
		states.running:
			if !parent.is_on_floor():
				if (_attack!=0): return states.jump_attack
				if parent.velocity.y!=0: return states.jump
			else:
				if (_attack!=0): return states.attack
				if parent.velocity.x==0: return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			if (_attack!=0): return states.jump_attack
		states.attack:
			if (_attack==0): return states.idle
		states.jump_attack:
			if (_attack==0): return states.jump
	return null


func _enter_state(new_state,old_state):
	match new_state:
		states.idle:
			parent.set_animation_idle()
		states.running:
			parent.set_animation_run()
		states.jump:
			parent.set_animation_jump()
		states.attack:
			parent.set_animation_attack()
		states.jump_attack:
			parent.set_animation_jump_attack()


func _exit_state(old_state,new_state):
	pass
