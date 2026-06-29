extends CharacterBody2D

# ==========================================
# MOVEMENT
# ==========================================

const SPEED := 400.0
const JUMP_VELOCITY := -650.0

var gravity: float = float(ProjectSettings.get_setting("physics/2d/default_gravity"))

# ==========================================
# COYOTE TIME
# ==========================================

const COYOTE_TIME := 0.5
var coyote_timer := 0.0
var was_on_floor := false

# ==========================================
# DAMAGE SETTINGS
# ==========================================

const KNOCKBACK_X := 400.0
const KNOCKBACK_Y := -300.0
const INVINCIBILITY_TIME := 1.0
const MOVEMENT_LOCK_TIME := 0.2

var invincible := false
var can_move := true
var dead := false

@onready var sprite: Sprite2D = $Sprite2D

# =========================================
# ON READY
# =========================================

func _ready():
	Global.registerCheckpoint(global_position)

# ==========================================
# GAME LOOP
# ==========================================

func _physics_process(delta: float) -> void:

	if dead:
		return

	# ❌ GLOBAL INPUT LOCK CHECK
	if Global.isPlayerInputDisabled():
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# ==========================================
	# COYOTE TIME UPDATE
	# ==========================================

	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# ==========================================
	# JUMP (with coyote time)
	# ==========================================

	if can_move and Input.is_action_just_pressed("Jump"):
		if is_on_floor() or coyote_timer > 0.0:
			print("Player position:", global_position)
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0.0

	# Horizontal movement
	if can_move:
		var direction := Input.get_axis("Move_Left", "Move_Right")

		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


# ==========================================
# DAMAGE
# ==========================================

func take_damage(from_position: Vector2) -> void:

	if invincible or dead:
		return

	invincible = true
	can_move = false

	Global.receiveDamage()

	if Global.hitPoints <= 0:
		die()
		return

	var direction: float = float(sign(global_position.x - from_position.x))

	if direction == 0.0:
		direction = 1.0

	velocity.x = direction * KNOCKBACK_X
	velocity.y = KNOCKBACK_Y

	start_invincibility()

# ==========================================
# RESPAWN
# ==========================================

func respawn() -> void:
		print("Respawning at:", Global.respawnCheckpoint)
	print("Player:", global_position)
	print("Camera:", get_viewport().get_camera_2d().global_position)

	dead = false
	invincible = false
	can_move = true

	velocity = Vector2.ZERO
	global_position = Global.respawnCheckpoint

	Global.restoreFullHealth()
	set_physics_process(true)

# ==========================================
# DEATH
# ==========================================

func die() -> void:

	dead = true
	can_move = false
	invincible = true

	velocity = Vector2.ZERO
	await get_tree().create_timer(1.0).timeout
	respawn()

	var death_screen = get_tree().current_scene.get_node("Death_Screen")

	if death_screen:
		print("Death screen called!")
		death_screen.show_death_screen()


# ==========================================
# INVINCIBILITY
# ==========================================

func start_invincibility() -> void:

	await get_tree().create_timer(MOVEMENT_LOCK_TIME).timeout

	if dead:
		return

	can_move = true

	var flash_count := 5
	var flash_time: float = INVINCIBILITY_TIME / float(flash_count * 2)

	for i in range(flash_count):

		sprite.visible = false
		await get_tree().create_timer(flash_time).timeout

		sprite.visible = true
		await get_tree().create_timer(flash_time).timeout

	sprite.visible = true
	invincible = false
