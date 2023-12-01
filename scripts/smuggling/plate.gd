extends Area2D


signal pressed
signal unpressed

enum Plate { SMALL, MEDIUM, BIG }
@export var type = Plate.MEDIUM

@export var one_off = false
var has_ben_pressed = false

var sfx_pressed = preload("res://assets/sfx/plate_pressed.mp3")
var sfx_unpressed = preload("res://assets/sfx/plate_unpressed.mp3")

var objects_on_the_plate = Dictionary()


func _ready():
	body_entered.connect(_on_self_body_entered)
	body_exited.connect(_on_self_body_exited)
	
	if type == Plate.SMALL:
		$AnimatedSprite2D.animation = "small_plate"
		$small_collision.disabled = false
		$medium_collisiion.disabled = true
		$big_collisiion.disabled = true
		$AudioStreamPlayer.pitch_scale = 1
	elif type == Plate.MEDIUM:
		$AnimatedSprite2D.animation = "medium_plate"
		$small_collision.disabled = true
		$medium_collisiion.disabled = false
		$big_collisiion.disabled = true
		$AudioStreamPlayer.pitch_scale = 0.9
	elif type == Plate.BIG:
		$AnimatedSprite2D.animation = "big_plate"
		$small_collision.disabled = true
		$medium_collisiion.disabled = true
		$big_collisiion.disabled = false
		$AudioStreamPlayer.pitch_scale = 0.8
	
	# Avoid sound while init
	await get_tree().create_timer(1).timeout
	$AudioStreamPlayer.volume_db = -1


func press():
	$AnimatedSprite2D.frame = 1
	$AudioStreamPlayer.stream = sfx_pressed
	$AudioStreamPlayer.play()
	has_ben_pressed = true
	emit_signal("pressed")


func unpress():
	$AnimatedSprite2D.frame = 0
	$AudioStreamPlayer.stream = sfx_unpressed
	$AudioStreamPlayer.play()
	emit_signal("unpressed")


func can_be_pressed(body):
	if type == Plate.SMALL:
		if body.is_in_group("player"): return true
		if body.is_in_group("cargo") and body.mass >= 10: return true
		return false
	elif type == Plate.MEDIUM:
		if body.is_in_group("cargo") and body.mass >= 20: return true
		return false
	elif type == Plate.BIG:
		if body.is_in_group("cargo") and body.mass >= 40: return true
		return false


func _on_self_body_entered(body):
	if has_ben_pressed and one_off: return
	if can_be_pressed(body): 
		if objects_on_the_plate.size() == 0:
			press()
		objects_on_the_plate[body.get_instance_id()] = body


func _on_self_body_exited(body):
	if has_ben_pressed and one_off: return
	if not objects_on_the_plate.has(body.get_instance_id()): return
	objects_on_the_plate.erase(body.get_instance_id())
	if objects_on_the_plate.size() == 0: unpress()
