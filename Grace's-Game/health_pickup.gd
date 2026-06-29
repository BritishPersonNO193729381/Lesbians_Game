extends Area2D

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return

	# Assuming your health is stored globally
	if Global.hitPoints >= Global.maxHitPoints:
		return  # ❌ do nothing if already full health

	# ✅ heal player
	Global.hitPoints += 1
	Global.hitPoints = min(Global.hitPoints, Global.maxHitPoints)

	Global.vitalityChanged.emit()

	queue_free()
