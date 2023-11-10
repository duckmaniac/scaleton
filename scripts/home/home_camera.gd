extends Camera2D


func _on_scaletons_door_to_scaletons_room():
	position = Vector2(960, 540)


func _on_exit_corridor_to_hallway():
	position = Vector2(960, 2700)


func _on_back_to_corridor_back_to_corridor():
	position = Vector2(960, 1620)


func _on_exit_room_to_corridor():
	position = Vector2(960, 1620)
