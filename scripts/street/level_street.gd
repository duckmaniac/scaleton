extends Node

var debug = true

func _ready():
	MusicController.set_track(1)
	MusicController.play_music()
	
	# intro
	if not debug:
		$scaleton.can_move = false
		$neighbours/intro.visible = true
		await get_tree().create_timer(3.2).timeout
		$neighbours/intro/author.visible = true
		await get_tree().create_timer(3.8).timeout
		$neighbours/intro.visible = false
		$scaleton.can_move = true
