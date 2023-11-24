extends RigidBody2D

@export var player: RigidBody2D = null
var push_force = 10
var is_being_pushed = false


#


func _on_area_2d_start_pushing():
	is_being_pushed = true


func _on_area_2d_stop_pushging():
	is_being_pushed = false
