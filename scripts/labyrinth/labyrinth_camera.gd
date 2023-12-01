extends Camera2D


@export var player: CharacterBody2D = null


func _process(_delta):
	if Input.is_action_just_released("zoom_in"):
		zoom.x += 0.1
		zoom.y += 0.1
	elif Input.is_action_just_released("zoom_out"):
		zoom.x -= 0.1
		zoom.y -= 0.1
	zoom.x = clamp(zoom.x, 0.5, 1)
	zoom.y = clamp(zoom.y, 0.5, 1)


func _physics_process(_delta):
	position = player.position
	if player.position.y > 540:
		position = Vector2(position.x, 540)
