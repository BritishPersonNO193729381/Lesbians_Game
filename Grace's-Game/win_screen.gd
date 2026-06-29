extends CanvasLayer

@onready var play_again_button: Button = $CenterContainer/VBoxContainer/play_again

func _ready() -> void:
	play_again_button.pressed.connect(_on_play_again_pressed)

func _on_play_again_pressed() -> void:
	# 1. Reset global player state
	Global.reinitializePlayerState()
	Global.activeLevel = 1
	Global.clearRespawnPoint()
	Global.enablePlayerInput()

	# 2. Reload current level scene
	get_tree().reload_current_scene()
