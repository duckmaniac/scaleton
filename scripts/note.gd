extends StaticBody2D
	
func interact(player):
	if $CanvasLayer.visible:
		$CanvasLayer.hide()
		player.can_move = true
	else:
		$CanvasLayer.show()
		player.can_move = false
