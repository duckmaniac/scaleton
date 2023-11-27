extends Interactable


signal pet


func interact():
	$AudioStreamPlayer.play()
	emit_signal("pet")
