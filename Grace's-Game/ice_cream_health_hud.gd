extends Node2D

@onready var states: Array[Node] = [
	$"0HP",
	$"1HP",
	$"2HP",
	$"3HP",
	$"4HP"
]

func _ready() -> void:
	Global.vitalityChanged.connect(update_health)
	update_health()

func update_health() -> void:

	for state in states:
		state.visible = false

	var health: int = int(clamp(Global.hitPoints, 0, states.size() - 1))

	states[health].visible = true
