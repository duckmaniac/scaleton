extends StaticBody2D

@export var sfx_on_show : Resource = null
@export var sfx_on_hide : Resource = null
	
func interact(player):
	if $CanvasLayer.visible:
		if sfx_on_hide != null:
			$AudioStreamPlayer.stream = sfx_on_hide
			$AudioStreamPlayer.play()
		$CanvasLayer.hide()
		player.can_move = true
	else:
		if sfx_on_show != null:
			$AudioStreamPlayer.stream = sfx_on_show
			$AudioStreamPlayer.play()
		$CanvasLayer.show()
		player.can_move = false
