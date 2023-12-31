extends CharacterBody2D

signal reached_point_to_walk

enum State {PLAYING, CUT_SCENE}

@export var speed = 300.0
var direction = Vector2.ZERO
var prev_direction = Vector2.ZERO
var can_move = true
var sprite = null
var prev_animation = null
var point_to_walk = null
var state = State.PLAYING

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
	wear_street_clothes()


func _process(_delta):
	if state != State.CUT_SCENE:
		process_interaction()
		set_direction()
	play_animation()


func _physics_process(delta):
	if state == State.PLAYING:
		if direction.length() != 0:
			move_character(delta)
			sound_steps()
	elif state == State.CUT_SCENE:
		if point_to_walk != null and position.distance_to(point_to_walk) > 10:
			velocity = position.direction_to(point_to_walk) * speed
			move_and_slide()
			sound_steps()
			
			if velocity.y < 0:
				direction.y = -1
			elif velocity.y > 0:
				direction.y = 1
			elif velocity.x < 0:
				direction.x = -1
			elif velocity.x > 0:
				direction.x = 1
		else:
			if direction != Vector2.ZERO:
				emit_signal("reached_point_to_walk")
			direction = Vector2.ZERO


func process_interaction():
	if Input.is_action_just_pressed("dance") and can_move:
		if prev_animation == "walk_backward" or prev_animation == "idle_backward":
			set_animation("dance_backward")
		else:
			set_animation("dance_forward")

	if Input.is_action_just_released("dance") and can_move:
		sprite.play(prev_animation)


func set_direction():
	if direction != Vector2.ZERO:
		prev_direction = direction
	
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
			set_animation("idle_forward")
		elif sprite.animation == "walk_backward":
			set_animation("idle_backward")
		if (sprite.animation != "dance_forward" and
			sprite.animation != "dance_backward"):
			sprite.stop()
		return
		
	if direction.x != 0:
		set_animation("walk_left")
		sprite.flip_h = direction.x > 0
	elif direction.y > 0:
		set_animation("walk_forward")
	elif direction.y < 0:
		set_animation("walk_backward")


func sound_steps():
	if not is_steps_sound_playing:
		is_steps_sound_playing = true
		var random_index = randi() % step_sounds.size()
		$StepsPlayer.stream = step_sounds[random_index]
		$StepsPlayer.play()


func move_character(_delta):
	direction = direction.normalized()
	velocity = direction * speed
	if move_and_slide():
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				col.get_collider().linear_velocity = col.get_normal() * -500


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


func teleport(new_position):
	set_deferred("interactable_object", null)
	set_deferred("position", new_position)
	

func set_animation(animation_name):
	prev_animation = sprite.animation
	sprite.play(animation_name)
	
	
func cut_scene_move_to_point(point):
	speed = 200
	can_move = false
	point_to_walk = point
	state = State.CUT_SCENE
	
	
func end_cut_scene():
	speed = 300
	can_move = true
	state = State.PLAYING
