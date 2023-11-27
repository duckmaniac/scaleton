extends Interactable

var was_animation_played = false

func interact():
	if not was_animation_played:
		$AnimatedSprite2D.play()
		$AudioStreamPlayer.play()
		was_animation_played = true
