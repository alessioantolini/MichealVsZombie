extends StateMachine

class_name ZombieState

var _attack: = 0.0

func _ready():
	add_state("idle")
	add_state("running")
	add_state("attack")
	add_state("dead")
	call_deferred("set_state",states.idle)

func AI():
	return

func _state_logic(delta):
	AI()
	parent.calculate_move_velocity(parent.velocity,parent.direction,parent.speed)
	parent.move_actor()
	return null

func _get_transition(delta):
	match state:
		states.idle:
			if (_attack!=0): return states.attack
			if parent.velocity.x!=0: return states.running
		states.running:
			if (_attack!=0): return states.attack
			if parent.velocity.x==0: return states.idle
		states.attack:
			if (_attack==0): return states.idle
	return null


func _enter_state(new_state,old_state):
	match new_state:
		states.idle:
			parent.set_animation_idle()
		states.running:
			parent.set_animation_run()
		states.attack:
			parent.set_animation_attack()
		states.dead:
			parent.set_animation_dead()


func _exit_state(old_state,new_state):
	pass
