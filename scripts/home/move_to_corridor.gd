extends Interactable

signal to_corridor

func interact():
	if player.is_dressed_in_street_clothes():
		player.teleport(Vector2(1442, 1721))
		emit_signal("to_corridor")
