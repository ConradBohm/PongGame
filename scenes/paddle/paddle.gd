extends CharacterBody2D


const SPEED : float = 300.0
var up_command : String
var down_command : String

func _physics_process(delta):
	if Input.is_action_pressed(up_command):
		velocity.y = -1 * SPEED * delta
		position += velocity
		
	if Input.is_action_pressed(down_command):
		velocity.y = SPEED * delta
		position += velocity
		
	move_and_slide()
