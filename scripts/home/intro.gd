extends Node

signal back_to_corridor

func interact(player):
	player.can_move = false
	$CanvasLayer.visible = true
	await get_tree().create_timer(1.5).timeout
	$CanvasLayer/author.visible = true
