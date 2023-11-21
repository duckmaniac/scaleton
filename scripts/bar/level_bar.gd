extends Node


var debug = false
var has_notes = false
var door_opened = false


func _ready():
	if not debug:
		MusicController.set_track(2)


func _on_piano_game_playing():
	if has_notes:
		$hall/interactions/piano_game.has_notes = true
		$hall/interactions/piano_game/CanvasLayer/notes.show()
		$hall/foreground/piano/notes.visible = true


func _on_d_second_dialog_ended():
	has_notes = true
	$hall/interactions/d_bar/CollisionShape2D.disabled = false


func _on_piano_game_secret_door_opened():
	door_opened = true
	$friend.change_state_to_dialog()
	$friend.position = Vector2(1530, 685)
	$friend/street_clothes_animation.animation = "idle_left";
	$scaleton.sprite.set_animation("walk_left")
	$scaleton.sprite.flip_h = true
	$hall/interactions/d_third/CollisionShape2D.disabled = false


func _on_d_third_dialog_ended():
	$hall/interactions/d_third/CollisionShape2D.position = Vector2.ZERO
	$hall/interactions/d_bar/CollisionShape2D.disabled = false
	$hall/interactions/d_fourth/CollisionShape2D.disabled = false
	$friend.change_state_to_walking()
	$friend.point_to_walk = Vector2(1419, 565)


func _on_d_first_dialog_ended():
	$friend.change_state_to_walking()
	$friend.point_to_walk = Vector2(1620, 685)


func _on_friend_reached_point_to_walk():
	if $friend.state != $friend.State.STATE_WALKING: return
	
	if not door_opened:
		$friend/street_clothes_animation.flip_h = false
		$friend/street_clothes_animation.animation = "sit"
	else:
		$friend.point_to_walk = Vector2(1624, 308)


func _on_d_fourth_dialog_ended():
	$hall/interactions/exit_bar/CollisionShape2D.disabled = false
	$hall/interactions/d_fourth/CollisionShape2D.position = Vector2.ZERO
	$scaleton.cut_scene_move_forward()
