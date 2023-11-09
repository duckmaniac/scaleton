extends StaticBody2D

enum LampType { green, red, small }
@export var lamp_color = LampType.green

var sound_on = preload("res://assets/sfx/lamp_on.mp3")
var sound_off = preload("res://assets/sfx/lamp_off.mp3")

func _ready():
	if lamp_color == LampType.green:
		$AnimatedSprite2D.animation = "green"
	elif lamp_color == LampType.red:
		$AnimatedSprite2D.animation = "red"
	elif lamp_color == LampType.small:
		$AnimatedSprite2D.animation = "small"	
	
func interact(_player):
	if $PointLight2D.enabled:
		$AudioStreamPlayer.stream = sound_off
	else:
		$AudioStreamPlayer.stream = sound_on
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.play()

func _on_animated_sprite_2d_animation_finished():
	$PointLight2D.enabled = not $PointLight2D.enabled
