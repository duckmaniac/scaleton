extends Node

func _ready():
	$scaleton.can_move = false
	$scaleton.wear_home_clothes()
	MusicController.set_track(0)
	MusicController.play_music()
