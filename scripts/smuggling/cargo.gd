extends RigidBody2D


var prev_position


func _ready():
	prev_position = position
	await get_tree().create_timer(1).timeout
	$AudioStreamPlayer.volume_db = 0


func _physics_process(_delta):
	if position == prev_position:
		$AudioStreamPlayer.stop()
	elif $AudioStreamPlayer.get_playback_position() == 0:
		$AudioStreamPlayer.play()
	prev_position = position
