extends Node

# ==========================================
# SIGNALS
# ==========================================

signal health_changed

# ==========================================
# PLAYER DATA
# ==========================================

var max_player_health: int = 4
var player_health: int = 3

var player_score: int = 0
var player_coins: int = 0
var player_keys: int = 0

# ==========================================
# LEVEL DATA
# ==========================================

var current_level: int = 1
var spawn_position: Vector2 = Vector2.ZERO

# ==========================================
# SETTINGS
# ==========================================

var sound_enabled: bool = true
var music_enabled: bool = true
var menu_world_position: Vector2 = Vector2.ZERO

# ==========================================
# INPUT CONTROL SYSTEM (NEW)
# ==========================================

var player_input_locked: bool = false

func lock_player_input() -> void:
	player_input_locked = true

func unlock_player_input() -> void:
	player_input_locked = false

func is_input_locked() -> bool:
	return player_input_locked


# ==========================================
# PLAYER ACTIONS
# ==========================================

func damage_player() -> void:
	player_health = max(player_health - 1, 0)
	health_changed.emit()

func heal_player() -> void:
	player_health = min(player_health + 1, max_player_health)
	health_changed.emit()

func full_heal() -> void:
	player_health = max_player_health
	health_changed.emit()

# ==========================================
# SCORE / COLLECTABLES
# ==========================================

func add_key() -> void:
	player_keys += 1

func add_score(amount: int) -> void:
	player_score += amount

func add_coin() -> void:
	player_coins += 1

# ==========================================
# SPAWN SYSTEM
# ==========================================

func set_checkpoint(position: Vector2) -> void:
	spawn_position = position

func set_spawn(position: Vector2) -> void:
	spawn_position = position

func clear_spawn() -> void:
	spawn_position = Vector2.ZERO

# ==========================================
# GAME RESET
# ==========================================

func reset_player() -> void:
	player_health = max_player_health
	player_score = 0
	player_coins = 0
	player_keys = 0

	health_changed.emit()
