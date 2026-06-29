extends StaticBody2D

@export var required_keys: int = 1
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var unlocked := false

func _process(_delta):
	if unlocked:
		return

	if Global.player_keys >= required_keys:
		unlock_block()

func unlock_block() -> void:
	unlocked = true

	# Option 1: remove collision (player can pass through)
	collision.set_deferred("disabled", true)

	# Option 2: hide it (optional visual feedback)
	sprite.visible = false
