extends Node


var debug = false
var pressed_counter = 0


func _ready():
	if not debug:
		MusicController.set_track(4)
		$scaleton.cut_scene_move_to_point(Vector2(1369, 944))
		$secreet_room/secreet_door_sfx.play(2.5)


func _on_scaleton_reached_point_to_walk():
	$scaleton.end_cut_scene()


func _on_first_plate_pressed():
	$tonell/interactions/door.open()


func _on_valve_water_closed():
	$secreet_room/highlight/star2.visible = false
	
	
func plate_pressed():
	pressed_counter += 1
	if pressed_counter == 3: 
		$cargo_puzzle/interactions/door.open()


func _on_small_plate_pressed():
	plate_pressed()


func _on_small_plate_unpressed():
	pressed_counter -= 1


func _on_medium_plate_pressed():
	plate_pressed()


func _on_medium_plate_unpressed():
	pressed_counter -= 1


func _on_big_plate_pressed():
	plate_pressed()


func _on_big_plate_unpressed():
	pressed_counter -= 1
