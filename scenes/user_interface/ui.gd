extends CanvasLayer

signal game_started
signal game_quit
signal p1_cpu(is_paddle_cpu)
signal p2_cpu(is_paddle_cpu)

@onready var player1_score : Label = $Player1Score
@onready var player2_score : Label = $Player2Score
@onready var main_menu : Control = $Control
@onready var button_sound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	player1_score.modulate = Color(1.0,1.0,1.0,0.0)
	player2_score.modulate = Color(1.0,1.0,1.0,0.0)
	Globals.connect("update_scores", update_text)
	
func update_text():
	player1_score.text = str(Globals.player1_score)
	player2_score.text = str(Globals.player2_score)

func show_menu():
	$Control/HBoxContainer/PlayButton.disabled = false
	$Control/HBoxContainer/QuitButton.disabled = false
	$"Control/VBoxContainer/P1 CPU".disabled = false
	$"Control/VBoxContainer/P2 CPU".disabled = false
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(main_menu, "modulate", Color(1.0,1.0,1.0,1.0), 1.0)
	tween.tween_property(player1_score, "modulate", Color(1.0,1.0,1.0,0.0), 1.0)
	tween.tween_property(player2_score, "modulate", Color(1.0,1.0,1.0,0.0), 1.0)

func _on_play_button_pressed():
	button_sound.play()
	
	$Control/HBoxContainer/PlayButton.disabled = true
	$Control/HBoxContainer/QuitButton.disabled = true
	$"Control/VBoxContainer/P1 CPU".disabled = true
	$"Control/VBoxContainer/P2 CPU".disabled = true
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(main_menu, "modulate", Color(1.0,1.0,1.0,0.0), 1.0)
	tween.tween_property(player1_score, "modulate", Color(1.0,1.0,1.0,1.0), 1.0)
	tween.tween_property(player2_score, "modulate", Color(1.0,1.0,1.0,1.0), 1.0)
	
	game_started.emit()
	
	
func _on_quit_button_pressed():
	game_quit.emit()



func _on_p_1_cpu_toggled(button_pressed):
	button_sound.play()
	p1_cpu.emit(button_pressed)


func _on_p_2_cpu_toggled(button_pressed):
	button_sound.play()
	p2_cpu.emit(button_pressed)
