extends Interactable


signal to_secreet_room


func interact():
	player.teleport(Vector2(570, 471))
	emit_signal("to_secreet_room")
