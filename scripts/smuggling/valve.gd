extends Node


signal water_closed
var has_been_interacted = false
	
	
func interact(_player):
	if has_been_interacted: return
	has_been_interacted = true
	$valve_sfx.play()
	$AnimationPlayer.play("close_water")
	emit_signal("water_closed")
