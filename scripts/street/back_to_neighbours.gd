extends Interactable


signal to_neighbours


func interact():
	player.teleport(Vector2(1807, player.position.y - 1180))
	emit_signal("to_neighbours")
