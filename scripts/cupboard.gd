extends StaticBody2D
	
func interact(player):
	if $AnimatedSprite2D.animation != "opened":
		$AnimatedSprite2D.play("opened")
		player.change_clothes()
