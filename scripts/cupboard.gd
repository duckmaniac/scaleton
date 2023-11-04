extends StaticBody2D
	
func interact():
	if $AnimatedSprite2D.animation != "opened":
		$AnimatedSprite2D.play("opened")
