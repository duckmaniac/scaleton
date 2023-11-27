extends Interactable


signal clothes_changed


func interact():
	if $AnimatedSprite2D.animation != "opened":
		$AudioStreamPlayer.play()
		$AnimatedSprite2D.play("opened")
		player.wear_street_clothes()
		emit_signal("clothes_changed")
