extends Node


var debug = false


func _ready():
	if not debug:
		MusicController.set_track(3)
		$scaleton.cut_scene_move_to_point(Vector2(1369, 944))
		$secreet_room/secreet_door_sfx.play(2.5)


func _on_scaleton_reached_point_to_walk():
	$scaleton.end_cut_scene()
