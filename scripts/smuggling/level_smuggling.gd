extends Node


var debug = false


func _ready():
	if not debug:
		MusicController.set_track(3)
