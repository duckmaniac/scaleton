extends StaticBody2D
	
func interact(player):
	if $AnimatedSprite2D.animation != "opened":
		$AudioStreamPlayer.play()
		$AnimatedSprite2D.play("opened")
		player.wear_street_clothes()
