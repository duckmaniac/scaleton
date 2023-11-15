extends CharacterBody2D


@export var destinations = []
var current_index = 0
var speed = 150 * 60
var is_flying = false
var start_position


func _ready():
	start_position = position


func _physics_process(delta):
	if is_flying:
		if position.distance_to(destinations[current_index]) > 5:
				velocity = position.direction_to(destinations[current_index]) * speed * delta
				move_and_slide()
		elif current_index < destinations.size() - 1: 
			current_index += 1
		else:
			stop_flying()


func add_rand_point(to_front=false):
	var destination = Vector2(
			randf_range(position.x - 200, position.x + 200), 
			randf_range(position.y - 200, position.y + 200)
		)
	if to_front:
		destinations.push_back(destination)
	else:
		destinations.push_back(destination)
	
	
func start_flying():
	current_index = 0
	destinations.clear()
	for i in range(0, randi_range(5, 15)):
		add_rand_point(true)
	destinations.push_back(start_position)
	is_flying = true
	$AnimatedSprite2D.frame = randi_range(0, 1)
	$AnimatedSprite2D.play("fly")
	
	
func stop_flying():
	is_flying = false
	$AnimatedSprite2D.stop()
