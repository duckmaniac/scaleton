extends CharacterBody2D

var screen_size

@export var speed = 380.0
var direction = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	set_direction()
	play_animation()
	move_character(delta)

func set_direction():
	direction = Vector2.ZERO
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
		$AnimatedSprite2D.play("idle")
		return
	
	if direction.x != 0:
		$AnimatedSprite2D.play("walk_left")
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = direction.x > 0
	elif direction.y > 0:
		$AnimatedSprite2D.play("walk_forward")
	elif direction.y < 0:
		$AnimatedSprite2D.play("walk_backward")


func move_character(delta):
	direction = direction.normalized()
	move_and_collide(direction * speed * delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
