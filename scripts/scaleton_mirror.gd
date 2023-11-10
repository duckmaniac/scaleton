extends RigidBody2D


var screen_size

@export var scaleton: RigidBody2D = null

@export var speed = 380.0
var direction = Vector2.ZERO
var can_move = true
var sprite = null
var prev_animation = null


func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	wear_street_clothes()


func _process(delta):
	process_interaction()
	set_direction()
	play_animation()
	
	if direction.length() != 0:
		move_character(delta)
		
func process_interaction():	
	if Input.is_action_just_pressed("dance") and can_move:
		if prev_animation == "walk_forward":
			set_animation("dance_forward")
		else:
			set_animation("dance_backward")

	if Input.is_action_just_released("dance") and can_move:
		sprite.play(prev_animation)


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
		set_animation("walk_backward")
	elif direction.y < 0:
		set_animation("walk_forward")


func move_character(_delta):
	position = Vector2(scaleton.position.x, -scaleton.position.y + 5500)


func wear_street_clothes():
	sprite = get_node("street_clothes_animation")
	$home_clothes_animation.hide()
	$street_clothes_animation.show()


func is_dressed_in_street_clothes():
	return sprite == get_node("street_clothes_animation")


func set_animation(animation_name):
	prev_animation = sprite.animation
	sprite.play(animation_name)
