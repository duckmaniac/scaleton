extends Node


var ost = [
	preload("res://assets/music/00.menu.mp3"),
	preload("res://assets/music/01.farewell.mp3"),
	preload("res://assets/music/02.friend.mp3"),
	preload("res://assets/music/03.bar.mp3"),
	preload("res://assets/music/04.smuggling.mp3")
]
var current_track = 0
	
	
func play_music():
	$music.stream = ost[current_track]
	$AnimationPlayer.play("ease_in")
	$music.play()
	
	
func pause_music():
	$music.pause()
	
	
func set_track(track_number):
	current_track = track_number
	if is_playing():
		$AnimationPlayer.play("ease_out")
	else:
		play_music()


func is_playing():
	return $music.get_playback_position() != 0


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ease_out":
		play_music()
