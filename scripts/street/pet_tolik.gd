extends StaticBody2D


signal pet


func interact(_player):
	$AudioStreamPlayer.play()
	emit_signal("pet")
