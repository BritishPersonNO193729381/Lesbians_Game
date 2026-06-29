extends Area2D

@export var win_ui_path: NodePath

@onready var win_ui: CenterContainer = $Win_Screen/CenterContainer

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		trigger_win()

func trigger_win() -> void:
	get_tree().paused = true
	if win_ui:
		win_ui.visible = true
