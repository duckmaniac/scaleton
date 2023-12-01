extends Node


func _ready():
	$scaleton.can_move = false
	$scaleton.wear_home_clothes()
	MusicController.set_track(1)


func _on_cupboard_clothes_changed():
	$scaletons_room/interactions/d_exit_room/CollisionShape2D.disabled = true
	$scaletons_room/highlight/star.visible = false


func _on_flower_leaf_fell():
	$scaletons_room/highlight/star4.visible = false
