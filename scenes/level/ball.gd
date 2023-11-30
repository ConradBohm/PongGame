extends RigidBody2D

@onready var collision_sound : AudioStreamPlayer2D = $CollisionSound

func _process(_delta):
	Globals.ball_location = global_position
	

func _on_timer_timeout():
	linear_velocity *= 1.05


func _on_body_exited(_body):
	collision_sound.play(global_position.x)
