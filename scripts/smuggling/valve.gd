extends Interactable


signal water_closed
	
	
func interact():
	$valve_sfx.play()
	$AnimationPlayer.play("close_water")
	emit_signal("water_closed")
