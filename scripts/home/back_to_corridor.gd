extends Node

signal back_to_corridor

func interact(player):
	player.set_deferred("position", Vector2(132, player.position.y - 1080))
	emit_signal("back_to_corridor")
