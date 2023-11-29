extends Node


var is_opened = false


func open():
	if is_opened: return
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("open_door")
	is_opened = true
