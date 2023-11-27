extends Interactable

signal to_hallway

func interact():
	player.teleport(Vector2(1790, player.position.y + 1080))
	emit_signal("to_hallway")
