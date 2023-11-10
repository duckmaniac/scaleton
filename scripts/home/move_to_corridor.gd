extends StaticBody2D

signal to_corridor

func interact(player):
	if player.is_dressed_in_street_clothes():
		player.teleport(Vector2(1442, 1721))
		emit_signal("to_corridor")
	else:
		$d_exit_room.interact(player)
