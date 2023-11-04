extends RigidBody2D

var screen_size

@export var speed = 380.0
var direction = Vector2.ZERO
var interactable_object = null

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	process_interaction()
	set_direction()
	play_animation()
	move_character(delta)
	
func process_interaction():
	if Input.is_action_just_pressed("interact") and interactable_object != null:
		interactable_object.interact()

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
		if $AnimatedSprite2D.animation == "walk_forward":
			$AnimatedSprite2D.play("idle_forward")
		elif $AnimatedSprite2D.animation == "walk_backward":
			$AnimatedSprite2D.play("idle_backward")
		$AnimatedSprite2D.stop()
		return
	
	if direction.x != 0:
		$AnimatedSprite2D.play("walk_left")
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = direction.x > 0
	elif direction.y > 0:
		$AnimatedSprite2D.play("walk_forward")
	elif direction.y < 0:
		$AnimatedSprite2D.play("walk_backward")
	else:
		$AnimatedSprite2D.play("idle")


func move_character(delta):
	direction = direction.normalized()
	move_and_collide(direction * speed * delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_body_entered(body):
	if body.is_in_group("interactable"):
		interactable_object = body
		
		
func _on_body_exited(body):
	if body.is_in_group("interactable"):
		interactable_object = null
