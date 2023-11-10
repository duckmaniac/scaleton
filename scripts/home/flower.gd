extends StaticBody2D

var was_animation_played = false

func interact(_player):
	if not was_animation_played:
		$AnimatedSprite2D.play()
		$AudioStreamPlayer.play()
		was_animation_played = true
