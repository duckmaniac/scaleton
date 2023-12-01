extends Node


var continue_game = true
var can_continue = true


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if LevelController.game_data["current_level"] != LevelController.Levels.ENDING:
		MusicController.set_track(0)
	elif not MusicController.is_playing():
		MusicController.set_track(7)
	
	if not LevelController.game_data["max_opened_level"] > 0:
		can_continue = false
		select_new_game()
		$CanvasLayer/continue.add_theme_color_override("font_color", Color("7e7289"))


func select_continue():
	if not can_continue: return
	$CanvasLayer/new_game.add_theme_constant_override("outline_size", 0)
	$CanvasLayer/continue.add_theme_constant_override("outline_size", 3)
	$CanvasLayer/new_game.add_theme_font_size_override("font_size", 80)
	$CanvasLayer/continue.add_theme_font_size_override("font_size", 100)
	continue_game = true


func select_new_game():
	$CanvasLayer/new_game.add_theme_constant_override("outline_size", 3)
	$CanvasLayer/continue.add_theme_constant_override("outline_size", 0)
	$CanvasLayer/new_game.add_theme_font_size_override("font_size", 100)
	$CanvasLayer/continue.add_theme_font_size_override("font_size", 80)
	continue_game = false


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if continue_game:
			LevelController.continue_game()
		else:
			LevelController.start_new_game()
	elif Input.is_action_just_pressed("ui_up"):
		select_new_game()
	elif Input.is_action_just_pressed("ui_down"):
		select_continue()
