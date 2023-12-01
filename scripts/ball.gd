extends RigidBody2D


signal friend_kick
signal scaleton_kick

var has_been_kicked = false
var can_be_kicked = true
var timer = Timer.new()
var kick_strength = 23000
var reset_state = false
var is_forced_move = true


func _ready():
	add_child(timer)
	timer.wait_time = 0.5
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()
		
		
func _on_Timer_timeout():
	can_be_kicked = true


func kick(direction):
	set_linear_velocity(Vector2(0, linear_velocity.y))
	apply_force(direction * kick_strength)
	has_been_kicked = true
	$AudioStreamPlayer.pitch_scale = randf_range(0.6, 1)
	$AudioStreamPlayer.play()
	can_be_kicked = false
	timer.start()


func _process(_delta):
	if has_been_kicked and abs(linear_velocity.x) < 100 and is_forced_move:
		if linear_velocity.x >= 0:
			apply_central_force(Vector2(100, 0))
		else:
			apply_central_force(Vector2(-100, 0))

	# Rotation.
	if linear_velocity.x > 0:
		set_angular_velocity(linear_velocity.x / 55)
	elif linear_velocity.x < 0:
		set_angular_velocity(linear_velocity.x / 55)
	else:
		set_angular_velocity(0)


func _on_body_entered(body):
	if can_be_kicked and body.is_in_group("player"):
		kick(Vector2(1, body.direction.y))
		emit_signal("scaleton_kick")
	elif can_be_kicked and body.is_in_group("friend"):
		kick(Vector2(-1, 0))
		body.error *= 3.5
		emit_signal("friend_kick")

	
func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, Vector2(602, 668))
		set_linear_velocity(Vector2(0, 0))
		reset_state = false
		has_been_kicked = false
		can_be_kicked = true
