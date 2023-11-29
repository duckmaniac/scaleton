extends Interactable


signal to_cargo_puzzle


func interact():
	player.teleport(Vector2(1351, 3410))
	emit_signal("to_cargo_puzzle")
