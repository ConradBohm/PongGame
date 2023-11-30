extends CharacterBody2D

const SPEED : float = 300.0
var up_command : String
var down_command : String

@onready var initial_position : Vector2 = global_position

@export var is_cpu_controlled : bool = false


func _physics_process(delta):
	var target : Vector2
	
	if is_cpu_controlled:
		if Globals.ball_exists:
			target = Globals.ball_location
		else:
			target = initial_position
			
		cpu_control(delta, target)
	else:
		player_control(delta)
		
	move_and_slide()
	
func cpu_control(delta, location):
	if location.y <= position.y:
		velocity.y = -1 * SPEED * delta
		position += velocity
	else:
		velocity.y = SPEED * delta
		position += velocity
	
func player_control(delta):
	if Input.is_action_pressed(up_command):
		velocity.y = -1 * (SPEED - 60.0) * delta
		position += velocity
		
	if Input.is_action_pressed(down_command):
		velocity.y = (SPEED - 60.0) * delta
		position += velocity

	
