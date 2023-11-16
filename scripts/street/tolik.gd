extends CharacterBody2D


@export var player: RigidBody2D = null

enum State {STATE_IDLE, STATE_SIT, STATE_STAND, STATE_RUN}
var state = State.STATE_IDLE
var timer = Timer.new()
var timer_after_pet = Timer.new()
var direction_x = 1
var next_animation = null
var speed = 150 * 60
var start_position
var was_pet = false
var can_move_after_pet = false


func _ready():
	randomize()
	add_child(timer)
	timer.wait_time = 0.5
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()
	add_child(timer_after_pet)
	timer_after_pet.wait_time = 5
	timer_after_pet.connect("timeout", Callable(self, "_on_Timer_after_pet_timeout"))
	start_position = position
	
	
func _on_Timer_timeout():
	# Tail animations.
	if state == State.STATE_IDLE:
		if randi_range(0, 1) == 1:
			switch_idle_animation()
	elif state == State.STATE_SIT:
		if randi_range(0, 1) == 1:
			switch_sit_animation()
	elif state == State.STATE_STAND:
		if randi_range(0, 1) == 1:
			switch_stand_animation()


func _on_Timer_after_pet_timeout():
	can_move_after_pet = true


func _physics_process(delta):
	$AnimatedSprite2D.flip_h = velocity.x > 0
	
	if not was_pet and position.distance_to(player.position) < 150:
		if state == State.STATE_SIT: return
		switch_animation_to_stand()
	elif not was_pet and position.distance_to(player.position) < 500:
		switch_animation_to_run()
		velocity = position.direction_to(player.position) * speed * delta
		move_and_slide()
	elif was_pet and position.distance_to(player.position) > 150 and position.distance_to(start_position) > 10:
		if can_move_after_pet:
			switch_animation_to_run()
			velocity = position.direction_to(start_position) * speed * delta
			move_and_slide()
		elif timer_after_pet.is_stopped():
			timer_after_pet.start()
	elif state != State.STATE_IDLE and state != State.STATE_SIT:
		$AnimatedSprite2D.play("to_idle")

func switch_idle_animation():
	if $AnimatedSprite2D.animation == "idle1":
		$AnimatedSprite2D.animation = "idle2"
	else:
		$AnimatedSprite2D.animation = "idle1"


func switch_sit_animation():
	if $AnimatedSprite2D.animation == "sit1":
		$AnimatedSprite2D.animation = "sit2"
	else:
		$AnimatedSprite2D.animation = "sit1"
		
		
func switch_stand_animation():
	if $AnimatedSprite2D.animation == "stand1":
		$AnimatedSprite2D.animation = "stand2"
	else:
		$AnimatedSprite2D.animation = "stand1"
		
		
func switch_animation_to_run():
	if $AnimatedSprite2D.animation == "run": return
	
	state = State.STATE_RUN
	if $AnimatedSprite2D.animation == "stand1" or $AnimatedSprite2D.animation == "stand2":
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("stand_up")
		$AudioStreamPlayer2D.stop()
		next_animation = "run"


func switch_animation_to_sit():
	if $AnimatedSprite2D.animation == "sit1" or $AnimatedSprite2D.animation == "sit2": return
	
	state = State.STATE_SIT
	$AnimatedSprite2D.play("sit_down")
	next_animation = "sit1"
	
	
func switch_animation_to_stand():
	if $AnimatedSprite2D.animation == "stand1" or $AnimatedSprite2D.animation == "stand2": return
	
	state = State.STATE_STAND
	$AnimatedSprite2D.play("stand1")
	$AudioStreamPlayer2D.stop()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "to_idle":
		state = State.STATE_IDLE
		return
	if next_animation == null: return
	$AnimatedSprite2D.play(next_animation)


func _on_pet_activator_pet():
	was_pet = true
	$AudioStreamPlayer2D.play()
	switch_animation_to_sit()
