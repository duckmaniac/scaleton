extends Node

var couch_on = preload("res://assets/sfx/couch_on.mp3")
var couch_off = preload("res://assets/sfx/couch_off.mp3")

var is_sitting = false

func interact(player):
	if not is_sitting:
		is_sitting = true
		player.can_move = false
		player.sprite.play("sit")
		player.sprite.flip_h = true
		player.position = Vector2(1633, 797)
		$AudioStreamPlayer.stream = couch_on
		$AudioStreamPlayer.play()
	else:
		is_sitting = false 
		player.can_move = true
		player.sprite.play("walk_left")
		player.sprite.flip_h = true
		player.position = Vector2(1512, 810)
		$AudioStreamPlayer.stream = couch_off
		$AudioStreamPlayer.play()
