extends CanvasLayer


func light_on():
	$AnimationPlayer.current_animation = "light_on"
	$AnimationPlayer.play()


func light_off():
	$AnimationPlayer.current_animation = "light_off"
	$AnimationPlayer.play()
