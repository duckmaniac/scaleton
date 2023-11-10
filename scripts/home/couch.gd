extends Node

var couch_on = preload("res://assets/sfx/couch_on.mp3")
var couch_off = preload("res://assets/sfx/couch_off.mp3")

var is_sitting = false

func interact(player):
	if not is_sitting:
		is_sitting = true
		player.can_move = false
		player.sprite.play("sit")
		player.position = Vector2(170, 2901)
		$AudioStreamPlayer.stream = couch_on
		$AudioStreamPlayer.play()
	else:
		is_sitting = false 
		player.can_move = true
		player.sprite.play("walk_left")
		player.sprite.flip_h = true
		player.position = Vector2(296, 2923)
		$AudioStreamPlayer.stream = couch_off
		$AudioStreamPlayer.play()
