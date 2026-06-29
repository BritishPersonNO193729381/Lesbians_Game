extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

var activated := false

func _ready():
	# optional: set visual based on state later
	pass


func _on_body_entered(body):
	print("Touched by:", body.name)
	if activated:
		return

	if body.is_in_group("Player"):
		activate_checkpoint()


func activate_checkpoint() -> void:
	activated = true
	print("Checkpoint activated at:", global_position)
	Global.registerCheckpoint(global_position)
