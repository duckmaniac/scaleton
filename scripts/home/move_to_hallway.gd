extends Node

signal to_hallway

func interact(player):
	player.set_deferred("position", Vector2(1790, player.position.y + 1080))
	emit_signal("to_hallway")
