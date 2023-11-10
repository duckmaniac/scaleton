extends RigidBody2D


func interact(player):
	apply_force(player.prev_direction * 30000)
	set_angular_velocity(10)
	
func _process(delta):
	if linear_velocity.x > 0:
		set_angular_velocity(linear_velocity.x / 50)
	elif linear_velocity.x < 0:
		set_angular_velocity(linear_velocity.x / 50)
	else:
		set_angular_velocity(0)
