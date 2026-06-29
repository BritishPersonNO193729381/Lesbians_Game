extends Area2D

@export var point_a: NodePath
@export var point_b: NodePath
@export var speed: float = 120.0
@export var damage: int = 1

var a_pos: Vector2
var b_pos: Vector2
var target: Vector2

# optional: prevents multi-hit spam while overlapping
var can_damage := true
const DAMAGE_COOLDOWN := 0.4

func _ready():
	a_pos = get_node(point_a).global_position
	b_pos = get_node(point_b).global_position
	target = b_pos

func _process(delta):
	global_position = global_position.move_toward(target, speed * delta)

	if global_position.distance_to(target) < 5.0:
		target = a_pos if target == b_pos else b_pos


func _on_body_entered(body):
	if not can_damage:
		return

	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(global_position)

			can_damage = false
			await get_tree().create_timer(DAMAGE_COOLDOWN).timeout
			can_damage = true
