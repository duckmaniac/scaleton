extends Node


var can_pull = true


func interact(player):
	if can_pull:
		$AudioStreamPlayer.play()
		can_pull = false
	$d_closed_door.interact(player)


func _on_d_closed_door_phrase_ended():
	can_pull = true
