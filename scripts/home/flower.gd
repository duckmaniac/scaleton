extends Node

var was_animation_played = false

func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	if not was_animation_played:
		$AnimatedSprite2D.play()
		was_animation_played = true
