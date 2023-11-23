extends Node


var timer = Timer.new()
var current_frame = 0


func _ready():
	randomize()
	add_child(timer)
	timer.wait_time = 1
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()
	
	
func _on_Timer_timeout():
	if randi_range(0, 3) == 1:
		$drop_animation.play("falling")


func _on_drop_animation_frame_changed():
	current_frame += 1
	if current_frame == 10:
		$drop_sfx.play()


func _on_drop_animation_animation_finished():
	current_frame = 0


func _on_valve_water_closed():
	timer.stop()
