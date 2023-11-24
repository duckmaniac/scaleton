extends Interactable


signal view_closed

@export var sfx_on_show : Resource = null
@export var sfx_on_hide : Resource = null
	

func interact():
	if $CanvasLayer.visible:
		if sfx_on_hide != null:
			$AudioStreamPlayer.stream = sfx_on_hide
			$AudioStreamPlayer.play()
		$CanvasLayer.hide()
		player.can_move = true
		emit_signal("view_closed")
	else:
		if sfx_on_show != null:
			$AudioStreamPlayer.stream = sfx_on_show
			$AudioStreamPlayer.play()
		$CanvasLayer.show()
		player.can_move = false
