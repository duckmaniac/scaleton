extends Node


var debug = false


func _ready():
	if not debug:
		MusicController.set_track(5)
	
	for child in $highlight_path.get_children():
		child.can_be_eaten = true
		
	$interactions/door/AudioStreamPlayer2D.volume_db = 15


func _on_small_plate_pressed():
	$interactions/door.open()
