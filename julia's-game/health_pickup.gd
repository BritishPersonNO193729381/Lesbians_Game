extends Area2D

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return

	# Assuming your health is stored globally
	if Global.player_health >= Global.max_player_health:
		return  # ❌ do nothing if already full health

	# ✅ heal player
	Global.player_health += 1
	Global.player_health = min(Global.player_health, Global.max_player_health)

	Global.health_changed.emit()

	queue_free()
