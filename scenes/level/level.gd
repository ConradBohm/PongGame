extends Node2D

var is_p1_cpu : bool
var is_p2_cpu : bool
var ball_being_made : bool
var ball_speed : int = 600

var paddle_scene : PackedScene = preload("res://scenes/paddle/paddle.tscn")
var ball_scene : PackedScene = preload("res://scenes/level/ball.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	init_game()

func _unhandled_key_input(event):
	if event.is_action_released("reset"):
		reset_game()
	
	if event.is_action("menu"):
		$UI.show_menu()
		
func init_game():
	spawn_player("p1")
	spawn_player("p2")	
	
	Globals.player1_score = 0
	Globals.player2_score = 0

func spawn_player(player) -> void:
	var paddle = paddle_scene.instantiate() as CharacterBody2D
	
	if player == "p1":
		paddle.position = $SpawnLocations/Player1Spawn.global_position
		paddle.up_command = "up_p1"
		paddle.down_command = "down_p1"
		if is_p1_cpu:
			paddle.is_cpu_controlled = true
	elif player == "p2":
		paddle.position = $SpawnLocations/Player2Spawn.global_position
		paddle.up_command = "up_p2"
		paddle.down_command = "down_p2"
		paddle.rotation = PI
		if is_p2_cpu:
			paddle.is_cpu_controlled = true
	else:
		print("Must set player as 'p1' or 'p2'.")
		
	$Units.add_child(paddle)

	
func spawn_ball():	
	await get_tree().create_timer(0.1).timeout
	for item in $Units.get_children():
		if item is RigidBody2D or ball_being_made:
			print("ball exists, not making a new one")
			return
	
	ball_being_made = true
	var ball = ball_scene.instantiate() as RigidBody2D
	ball.position = $SpawnLocations/BallSpawn.global_position
	
	var choice = [-1.0, 1.0]
	ball.linear_velocity = Vector2(choice[randi() % choice.size()], 0) * ball_speed # random left or right
	ball.linear_velocity.y = randf_range(-0.3,0.3) * ball_speed
	
	await get_tree().create_timer(3.0).timeout
	$Units.add_child(ball)
	Globals.ball_exists = true
	ball_being_made = false
	

func _on_right_goal_body_entered(body):
	Globals.player1_score += 1
	refresh_ball(body)

func _on_left_goal_body_entered(body):
	Globals.player2_score += 1
	refresh_ball(body)
	
func refresh_ball(body):
	body.queue_free()
	Globals.ball_exists = false
	spawn_ball()


func _on_ui_game_started():
	reset_game()
	

func _on_ui_game_quit():
	get_tree().quit()
	

func reset_game():
	for child in $Units.get_children():
		child.queue_free()

	init_game()
	spawn_ball()

func _on_ui_p_1_cpu(is_paddle_cpu):
	is_p1_cpu = is_paddle_cpu


func _on_ui_p_2_cpu(is_paddle_cpu):
	is_p2_cpu = is_paddle_cpu
