extends Node

signal update_scores

var player1_score : int = 0:
	set(value):
		player1_score = value
		update_scores.emit()

var player2_score : int = 0:
	set(value):
		player2_score = value
		update_scores.emit()
		
var ball_location : Vector2:
	set(value):
		ball_location = value

var ball_exists : bool = false:
	set(value):
		ball_exists = value
