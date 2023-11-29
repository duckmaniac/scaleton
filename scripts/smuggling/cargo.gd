extends RigidBody2D


var small_cargo_sprite = preload("res://assets/sprites/smuggling/small_cargo.png")
var big_cargo_sprite = preload("res://assets/sprites/smuggling/cargo.png")

enum Cargo { SMALL, BIG }
@export var type = Cargo.BIG

var prev_position


func _ready():
	if type == Cargo.SMALL:
		$Sprite2D.texture = small_cargo_sprite
		$Sprite2D.offset = Vector2(0, 12)
		linear_damp = 40
		mass = 20
		$AudioStreamPlayer.pitch_scale = 1
	elif type == Cargo.BIG:
		$Sprite2D.texture = big_cargo_sprite
		$Sprite2D.offset = Vector2(0, 5)
		linear_damp = 50
		mass = 40
		$AudioStreamPlayer.pitch_scale = 0.95
	prev_position = position
	await get_tree().create_timer(1).timeout
	$AudioStreamPlayer.volume_db = 0


func _physics_process(_delta):
	if position == prev_position:
		$AudioStreamPlayer.stop()
	elif $AudioStreamPlayer.get_playback_position() == 0:
		$AudioStreamPlayer.play()
	prev_position = position
