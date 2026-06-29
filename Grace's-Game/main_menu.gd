extends Control

enum MenuState { MAIN, CONTROLS, CREDITS }

var state: MenuState = MenuState.MAIN

# MAIN BACKGROUND
@onready var title_background: TextureRect = $Title_Screen_Background

# SCREENS
@onready var main_menu_ui: VBoxContainer = $MarginContainer/VBoxContainer
@onready var controls_screen: Panel = $Controls_Screen
@onready var credits_screen: Panel = $Credits_Screen


func _ready() -> void:

	main_menu_ui.visible = true
	controls_screen.visible = true
	credits_screen.visible = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = true
	set_state(MenuState.MAIN)


# -------------------------------------------------
# STATE HANDLER
# -------------------------------------------------
func set_state(new_state: MenuState) -> void:
	state = new_state

	# Main background only shows on main menu
	title_background.visible = (state == MenuState.MAIN)

	# Screens
	main_menu_ui.visible = (state == MenuState.MAIN)
	controls_screen.visible = (state == MenuState.CONTROLS)
	credits_screen.visible = (state == MenuState.CREDITS)


# -------------------------------------------------
# MAIN MENU BUTTONS
# -------------------------------------------------
func _on_play_pressed() -> void:
	Global.unlock_player_input()
	visible = false


func _on_control_help_pressed() -> void:
	set_state(MenuState.CONTROLS)


func _on_credz_pressed() -> void:
	set_state(MenuState.CREDITS)


# -------------------------------------------------
# BACK BUTTONS
# -------------------------------------------------
func _on_controls_back_pressed() -> void:
	set_state(MenuState.MAIN)


func _on_credits_back_pressed() -> void:
	set_state(MenuState.MAIN)
