extends CanvasLayer

# ==========================================
# NODES
# ==========================================

@onready var main_menu = $Main_Menu_Page
@onready var controls_page = $Controls_Page
@onready var credits_page = $Credits_Page

@onready var play_button = $Main_Menu_Page/VBoxContainer/Play
@onready var controls_button = $Main_Menu_Page/VBoxContainer/Control_Help
@onready var credits_button = $Main_Menu_Page/VBoxContainer/Credz

@onready var back_controls = $Controls_Page/VBoxContainer/Back
@onready var back_credits = $Credits_Page/VBoxContainer/Back


# ==========================================
# READY
# ==========================================

func _ready() -> void:
	# lock input while menu is open
	Global.disablePlayerInput()
	play_button.pressed.connect(_on_play)
	controls_button.pressed.connect(_show_controls)
	credits_button.pressed.connect(_show_credits)

	back_controls.pressed.connect(_show_main)
	back_credits.pressed.connect(_show_main)

	_show_main()

# =========================================
# MENU SETUP
# =========================================

func open_menu() -> void:
		Global.disablePlayerInput()
	var player := get_tree().get_first_node_in_group("Player")
	if player:
		Global.menu_world_position = player.global_position + Vector2(0, -60)

	self.visible = true

# ==========================================
# PAGE SWITCHING
# ==========================================

func _show_main() -> void:
	main_menu.visible = true
	controls_page.visible = false
	credits_page.visible = false


func _show_controls() -> void:
	main_menu.visible = false
	controls_page.visible = true
	credits_page.visible = false


func _show_credits() -> void:
	main_menu.visible = false
	controls_page.visible = false
	credits_page.visible = true


# ==========================================
# PLAY GAME
# ==========================================

func _on_play() -> void:
	# hide menu completely
	self.visible = false

	# unlock player input
	Global.enablePlayerInput()
