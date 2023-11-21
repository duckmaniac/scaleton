extends Node


var has_been_interacted = false


func interact(player):
	if not has_been_interacted:
		has_been_interacted = true
		$AudioStreamPlayer.play()
	$d_second.interact(player)
