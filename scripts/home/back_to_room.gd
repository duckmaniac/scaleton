extends Node

signal to_scaletons_room

func interact(player):
	player.teleport(Vector2(1380, 977))
	emit_signal("to_scaletons_room")
