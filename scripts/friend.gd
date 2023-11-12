extends CharacterBody2D

enum State {STATE_DIALOG, STATE_PLAY, STATE_WALKING}

@export var ball: RigidBody2D = null
var state = State.STATE_DIALOG
var speed = 200
var sprite = null
var direction = Vector2.ZERO
var timer = Timer.new()
var can_change_animation = true
var error = 0.0


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
			velocity = position.direction_to(Vector2(ball.position.x, ball.position.y - 60 + randf_range(error / 2, error))) * speed
			move_and_slide()
			
			if velocity.x < 0:
				direction.x = -1
			
		elif ball.position.x > 995 and position.distance_to(Vector2(1335, ball.position.y - 60)) > 10:
			velocity = position.direction_to(Vector2(1360, ball.position.y - 60)) * speed
			move_and_slide()
			
			if velocity.y < 0:
				direction.y = 1
			elif velocity.y > 0:
				direction.y = -1
			direction.x = 0
		else:
			direction = Vector2.ZERO
