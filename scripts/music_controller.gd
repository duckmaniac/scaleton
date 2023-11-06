extends Node

var ost = [preload("res://assets/music/01.farewell.mp3")]

func play_music():
	$music.play()
	
func pause_music():
	$music.pause()
	
func set_track(number):
	$music.stream = ost[number]

func is_playing():
	return $music.get_playback_position() != 0
