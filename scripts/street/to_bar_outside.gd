extends Interactable

signal to_bar_outside

func interact():
	player.teleport(Vector2(91, player.position.y + 1180))
	emit_signal("to_bar_outside")
