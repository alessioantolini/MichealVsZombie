extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0,1000.0)
export var velocity: = Vector2.ZERO
export var gravity: = 3000.0
export var acceleration: = 50.0
export var direction:= Vector2.ZERO

#func _physics_process(delta):
	#velocity.y += gravity*delta
	#velocity.y = max(velocity.y,speed.y)
