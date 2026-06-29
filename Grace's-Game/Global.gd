extends Node

# ==========================================
# SIGNALS
# ==========================================

signal vitalityChanged

# ==========================================
# PLAYER DATA
# ==========================================

var maxHitPoints: int = 4
var hitPoints: int = 3

var playerScore: int = 0
var collectedTreasure: int = 0
var collectedKeys: int = 0

# ==========================================
# LEVEL DATA
# ==========================================

var activeLevel: int = 1
var respawnCheckpoint: Vector2 = Vector2.ZERO

# ==========================================
# SETTINGS
# ==========================================

var sound_enabled: bool = true
var music_enabled: bool = true
var menu_world_position: Vector2 = Vector2.ZERO

# ==========================================
# INPUT CONTROL SYSTEM (NEW)
# ==========================================

var inputDisabled: bool = false

func disablePlayerInput() -> void:
	inputDisabled = true

func enablePlayerInput() -> void:
	inputDisabled = false

func isPlayerInputDisabled() -> bool:
	return inputDisabled


# ==========================================
# PLAYER ACTIONS
# ==========================================

func receiveDamage() -> void:
	hitPoints = max(hitPoints - 1, 0)
	vitalityChanged.emit()

func restoreHealth() -> void:
	hitPoints = min(hitPoints + 1, maxHitPoints)
	vitalityChanged.emit()

func restoreFullHealth() -> void:
	hitPoints = maxHitPoints
	vitalityChanged.emit()

# ==========================================
# SCORE / COLLECTABLES
# ==========================================

func collectKey() -> void:
	collectedKeys += 1

func addPlayerScore(amount: int) -> void:
	playerScore += amount

func collectTreasure() -> void:
	collectedTreasure += 1

# ==========================================
# SPAWN SYSTEM
# ==========================================

func registerCheckpoint(position: Vector2) -> void:
	respawnCheckpoint = position

func setRespawnPoint(position: Vector2) -> void:
	respawnCheckpoint = position

func clearRespawnPoint() -> void:
	respawnCheckpoint = Vector2.ZERO

# ==========================================
# GAME RESET
# ==========================================

func reinitializePlayerState() -> void:
	hitPoints = maxHitPoints
	playerScore = 0
	collectedTreasure = 0
	collectedKeys = 0

	vitalityChanged.emit()
