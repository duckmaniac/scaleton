extends Interactable


signal to_tonell


func interact():
	player.teleport(Vector2(568, 2240))
	emit_signal("to_tonell")
