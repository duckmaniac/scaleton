extends CharacterBody2D

enum State {STATE_DIALOG, STATE_PLAY, STATE_WALKING}

@export var ball: RigidBody2D = null
var state = State.STATE_DIALOG
var speed = 200
var sprite = null
var direction = Vector2.ZERO
var timer = Timer.new()
var can_change_animation = true
var error = 1.0
var point_to_walk = null

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
	sprite = get_node("street_clothes_animation")
	add_child(timer)
	timer.wait_time = 0.1
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()
	
	
func _process(_delta):
	if can_change_animation:
		play_animation()
		can_change_animation = false
		
		
func _on_Timer_timeout():
	can_change_animation = true
	timer.start()


func play_animation():
	if state == State.STATE_DIALOG:
		sprite.play("idle_forward")
		return

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
		sprite.play("walk_backward")
	elif direction.y < 0:
		sprite.play("walk_forward")	


func _physics_process(_delta):
	if state == State.STATE_PLAY:
		if position.distance_to(ball.position) < 100 and position.x > 1279 and position.x < 1369:
			velocity = position.direction_to(Vector2(ball.position.x, ball.position.y - 60 + randf_range(0, error))) * speed
			move_and_slide()
			sound_steps()
			
			if velocity.x < 0:
				direction.x = -1
			elif velocity.x > 0:
				direction.x = 1
				
			
		elif ball.position.x > 995 and position.distance_to(Vector2(1335, ball.position.y - 60)) > 10:
			velocity = position.direction_to(Vector2(1360, ball.position.y - 60)) * speed
			move_and_slide()
			sound_steps()
			
			if velocity.y < 0:
				direction.y = 1
			elif velocity.y > 0:
				direction.y = -1
			direction.x = 0
		else:
			direction = Vector2.ZERO
			
	elif state == State.STATE_WALKING:
		if point_to_walk != null and position.distance_to(point_to_walk) > 10:
			velocity = position.direction_to(point_to_walk) * speed
			move_and_slide()
			sound_steps()	
			
			if velocity.x < 0:
				direction.x = -1
			elif velocity.x > 0:
				direction.x = 1


func sound_steps():
	if not is_steps_sound_playing:
		is_steps_sound_playing = true
		var random_index = randi() % step_sounds.size()
		$StepsPlayer.stream = step_sounds[random_index]
		$StepsPlayer.play()


func _on_steps_player_finished():
	is_steps_sound_playing = false


func _on_exit_neighbours_to_bar_outside():
	position = Vector2(230, 1722)
	state = State.STATE_WALKING
	point_to_walk = Vector2(1491, 1591)
