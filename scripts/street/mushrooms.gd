extends Node


func interact(_player):
	$AudioStreamPlayer.play()
	var child_count = get_child_count()
	for i in range(child_count):
		var child = get_child(i)
		if child.is_in_group("firefly"):
			child.start_flying()
