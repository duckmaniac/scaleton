extends Node

var was_animation_played = false

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if not was_animation_played:
		$AnimatedSprite2D.play()
		was_animation_played = true
