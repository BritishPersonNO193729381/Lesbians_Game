extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var player_spawn1: Marker2D = $Level1/Player_Spawn_Start
@onready var menu: CanvasLayer = $Main_Menu_V2


func _ready() -> void:
	# Game always runs in background
	get_tree().paused = false

	# LOCK PLAYER INPUT ON START (NEW)
	Global.lock_player_input()

	# Menu setup
	menu.process_mode = Node.PROCESS_MODE_ALWAYS
	menu.visible = true

	spawn_player()


func spawn_player() -> void:
	# Use saved spawn if it exists
	if Global.spawn_position != Vector2.ZERO:
		player.global_position = Global.spawn_position
	else:
		player.global_position = player_spawn1.global_position

	# Reset movement
	player.velocity = Vector2.ZERO
