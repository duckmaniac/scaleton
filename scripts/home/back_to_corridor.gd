extends Interactable

signal back_to_corridor

func interact():
	player.teleport(Vector2(132, player.position.y - 1080))
	emit_signal("back_to_corridor")
