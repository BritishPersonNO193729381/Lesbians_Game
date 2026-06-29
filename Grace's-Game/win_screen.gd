extends CanvasLayer

@onready var play_again_button: Button = $CenterContainer/VBoxContainer/play_again

func _ready() -> void:
	play_again_button.pressed.connect(_on_play_again_pressed)

func _on_play_again_pressed() -> void:
	# 1. Reset global player state
	Global.reset_player()
	Global.current_level = 1
	Global.clear_spawn()
	Global.unlock_player_input()

	# 2. Reload current level scene
	get_tree().reload_current_scene()
