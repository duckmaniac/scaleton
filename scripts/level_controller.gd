extends Node


enum Levels {HOME, STREET, BAR, SMUGGLING, LABYRINTH, ENDING, MENU}
var level_preloads = [
	preload("res://levels/home.tscn"), 
	preload("res://levels/street.tscn"),
	preload("res://levels/bar.tscn"),
	preload("res://levels/smuggling.tscn"),
	preload("res://levels/labyrinth.tscn"),
	preload("res://levels/ending.tscn"),
	preload("res://levels/menu.tscn")
]

const game_data_path = "user://game-data.json"
var game_data = {
	"current_level": 0,
	"max_opened_level": 0
}

var is_transition_to_menu = false


func save_data():
	var file = FileAccess.open(game_data_path, FileAccess.WRITE)
	file.store_var(game_data)
	file = null


func load_data():
	if FileAccess.file_exists(game_data_path):
		var file = FileAccess.open(game_data_path,FileAccess.READ)
		game_data = file.get_var()
	else:
		save_data()


func _ready():
	load_data()


func load_level(number):
	$AnimationPlayer.play("ease_in")
	game_data["current_level"] = number
	if number > game_data["max_opened_level"]:
		game_data["max_opened_level"] = number
	save_data()
	

func load_menu():
	$AnimationPlayer.play("ease_in")
	is_transition_to_menu = true


func continue_game():
	load_level(game_data["current_level"])


func start_new_game():
	game_data["current_level"] = Levels.HOME
	game_data["max_opened_level"] = Levels.HOME
	save_data()
	load_level(Levels.HOME)


func _on_animation_player_animation_finished(anim_name):
	if is_transition_to_menu: 
		is_transition_to_menu = false
		get_tree().change_scene_to_packed(level_preloads[Levels.MENU])
		$AnimationPlayer.play("ease_out")
		return

	if anim_name == "ease_in":
		get_tree().change_scene_to_packed(level_preloads[game_data["current_level"]])
		$AnimationPlayer.play("ease_out")
