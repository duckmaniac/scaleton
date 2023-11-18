extends Node2D


signal shown


func _ready():
	visible = false


func _process(_delta):
	if Input.is_action_just_pressed("highlight"):
		visible = true
		emit_signal("shown")
		
	if Input.is_action_just_released("highlight"):
		visible = false
