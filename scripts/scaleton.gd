extends RigidBody2D

var screen_size

@export var speed = 380.0
var direction = Vector2.ZERO
var interactable_object = null
var can_move = false
var sprite = null

func _ready():
	screen_size = get_viewport_rect().size
	sprite = get_node("AnimatedSprite2DHome")

func _process(delta):
	process_interaction()
	set_direction()
	play_animation()
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
		sprite.flip_v = false
		sprite.flip_h = direction.x > 0
	elif direction.y > 0:
		sprite.play("walk_forward")
	elif direction.y < 0:
		sprite.play("walk_backward")
	else:
		sprite.play("idle")


func move_character(delta):
	direction = direction.normalized()
	move_and_collide(direction * speed * delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_body_entered(body):
	if body.is_in_group("interactable"):
		interactable_object = body
	elif body.is_in_group("auto-interactable"):
		body.interact(self)
		
func _on_body_exited(body):
	if body.is_in_group("interactable"):
		interactable_object = null

func change_clothes():
	sprite = get_node("AnimatedSprite2D")
	$AnimatedSprite2DHome.hide()
	$AnimatedSprite2D.show()

func is_dressed_in_street_clothes():
	return sprite == get_node("AnimatedSprite2D")
