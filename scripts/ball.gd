extends RigidBody2D


var has_been_kicked = false
var kick_strength = 20000


func kick(direction):
	set_linear_velocity(Vector2(0, linear_velocity.y))
	apply_force(direction * kick_strength)
	has_been_kicked = true

# Player interaction.
func interact(player):
	kick(Vector2(1, player.prev_direction.y))


func _process(_delta):
	if has_been_kicked and abs(linear_velocity.x) < 100:
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


# Friend interaction.
func _on_body_entered(body):
	if body.is_in_group("friend"):
		kick(Vector2(-1, 0))
		body.error += 75
