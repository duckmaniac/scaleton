extends Node

func _ready():
	$scaleton.can_move = false
	$scaleton.wear_home_clothes()
	MusicController.set_track(0)


func _on_cupboard_clothes_changed():
	$scaletons_room/interactions/d_exit_room/CollisionShape2D.disabled = true
