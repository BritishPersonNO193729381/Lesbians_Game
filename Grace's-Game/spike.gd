extends Area2D

func _on_player_enters_spike(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(global_position)
