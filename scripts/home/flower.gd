extends Interactable


signal leaf_fell
var was_animation_played = false

func interact():
	if not was_animation_played:
		$AnimatedSprite2D.play()
		$AudioStreamPlayer.play()
		was_animation_played = true
		emit_signal("leaf_fell")
