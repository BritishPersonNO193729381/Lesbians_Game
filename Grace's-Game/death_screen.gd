extends CanvasLayer

# ==========================================
# CONFIG
# ==========================================

const LAYER_PRIORITY := 10

# ==========================================
# NODES
# ==========================================

@onready var menu: CenterContainer = $CenterContainer

@onready var retry_button: Button = $CenterContainer/Panel/VBoxContainer/Retry_Button
@onready var menu_button: Button = $CenterContainer/Panel/VBoxContainer/Menu_Button

# ==========================================
# STATE
# ==========================================

var showing := false

# ==========================================
# READY
# ==========================================

func _ready() -> void:
	layer = LAYER_PRIORITY

	hide()
	menu.visible = false

	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	retry_button.pressed.connect(_on_retry_pressed)

# ==========================================
# SHOW DEATH SCREEN
# ==========================================

func show_death_screen() -> void:
	if showing:
		return

	showing = true

	show()
	menu.visible = true

	get_tree().paused = true

# ==========================================
# RETRY
# ==========================================

func _on_retry_pressed() -> void:
	reset()

	get_tree().paused = false

	Global.reset_player()
	get_tree().reload_current_scene()

# ==========================================
# RESET
# ==========================================

func reset() -> void:
	showing = false

	hide()
	menu.visible = false
