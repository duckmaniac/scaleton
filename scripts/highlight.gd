extends Node2D

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("highlight"):
		visible = true
		
	if Input.is_action_just_released("highlight"):
		visible = false
