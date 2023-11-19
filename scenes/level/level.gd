extends Node2D

var p1_score : int
var p2_score : int

var paddle : PackedScene = preload("res://scenes/paddle/paddle.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	p1_score = 0
	p2_score = 0

	spawn_player("p1")
	spawn_player("p2")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawn_player(player):
	var player_instance = paddle.instantiate() as CharacterBody2D
	
	if player == "p1":
		player_instance.position = $SpawnLocations/Player1Spawn.global_position
		player_instance.up_command = "up_p1"
		player_instance.down_command = "down_p1"
	elif player == "p2":
		player_instance.position = $SpawnLocations/Player2Spawn.global_position
		player_instance.up_command = "up_p2"
		player_instance.down_command = "down_p2"
	else:
		print("Must set player as 'p1' or 'p2'.")
		
	$Paddles.add_child(player_instance)
	
