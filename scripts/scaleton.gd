extends RigidBody2D

var screen_size

@export var speed = 380.0
var direction = Vector2.ZERO
var interactable_object = null
var can_move = true
var sprite = null

# Preload the sounds
var step_sounds = [
	preload("res://assets/sfx/step1.mp3"),
	preload("res://assets/sfx/step2.mp3"),
	preload("res://assets/sfx/step3.mp3"),
	preload("res://assets/sfx/step4.mp3")
]
var is_steps_sound_playing = false

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	wear_street_clothes()

func _process(delta):
	process_interaction()
	set_direction()
	play_animation()
	
	if direction.length() != 0:
		sound_steps()
		move_character(delta)		
	
func process_interaction():
	if Input.is_action_just_pressed("interact") and interactable_object != null:
		interactable_object.interact(self)

func set_direction():
	direction = Vector2.ZERO
	if can_move:
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			direction.y += 1	
		if Input.is_action_pressed("ui_up"):
			direction.y -= 1

func play_animation():
	if direction.length() == 0:
		if sprite.animation == "walk_forward":
			sprite.play("idle_forward")
		elif sprite.animation == "walk_backward":
			sprite.play("idle_backward")
		sprite.stop()
		return
		
	if direction.x != 0:
		sprite.play("walk_left")
		sprite.flip_h = direction.x > 0
	elif direction.y > 0:
		sprite.play("walk_forward")
	elif direction.y < 0:
		sprite.play("walk_backward")
		
func sound_steps():
	if not is_steps_sound_playing:
		is_steps_sound_playing = true
		var random_index = randi() % step_sounds.size()
		$StepsPlayer.stream = step_sounds[random_index]
		$StepsPlayer.play()


func move_character(delta):
	direction = direction.normalized()
	move_and_collide(direction * speed * delta)


func _on_body_entered(body):
	if body.is_in_group("interactable"):
		interactable_object = body
	elif body.is_in_group("auto-interactable"):
		body.interact(self)
		
func _on_body_exited(body):
	if body.is_in_group("interactable"):
		interactable_object = null

func wear_home_clothes():
	sprite = get_node("home_clothes_animation")
	$street_clothes_animation.hide()
	$home_clothes_animation.show()
	

func wear_street_clothes():
	sprite = get_node("street_clothes_animation")
	$home_clothes_animation.hide()
	$street_clothes_animation.show()

func is_dressed_in_street_clothes():
	return sprite == get_node("street_clothes_animation")


func _on_steps_player_finished():
	is_steps_sound_playing = false
