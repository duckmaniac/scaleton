extends StaticBody2D
	
func interact(player):
	$AnimatedSprite2D.play("toggle")


func _on_animated_sprite_2d_animation_finished():
	$PointLight2D.enabled = not $PointLight2D.enabled
