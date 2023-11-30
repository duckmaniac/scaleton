extends Node


var continue_game = false
var can_continue = true


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	MusicController.set_track(0)
	
	if not LevelController.game_data["max_opened_level"] > 0:
		can_continue = false
		$CanvasLayer/continue.add_theme_color_override("font_color", Color("7e7289"))


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if continue_game:
			LevelController.continue_game()
		else:
			LevelController.start_new_game()
	elif Input.is_action_just_pressed("ui_up"):
		$CanvasLayer/new_game.add_theme_constant_override("outline_size", 3)
		$CanvasLayer/continue.add_theme_constant_override("outline_size", 0)
		$CanvasLayer/new_game.add_theme_font_size_override("font_size", 100)
		$CanvasLayer/continue.add_theme_font_size_override("font_size", 80)
		continue_game = false
	elif Input.is_action_just_pressed("ui_down"):
		if not can_continue: return
		$CanvasLayer/new_game.add_theme_constant_override("outline_size", 0)
		$CanvasLayer/continue.add_theme_constant_override("outline_size", 3)
		$CanvasLayer/new_game.add_theme_font_size_override("font_size", 80)
		$CanvasLayer/continue.add_theme_font_size_override("font_size", 100)
		continue_game = true
