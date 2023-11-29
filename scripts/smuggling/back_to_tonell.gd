extends Interactable


signal to_tonell


func interact():
	player.teleport(Vector2(1301, 1691))
	emit_signal("to_tonell")
