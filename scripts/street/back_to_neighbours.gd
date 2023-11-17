extends StaticBody2D


signal to_neighbours


func interact(player):
	player.teleport(Vector2(1807, player.position.y - 1180))
	emit_signal("to_neighbours")
