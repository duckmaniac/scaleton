extends Node


var counter = 2


func _ready():
	MusicController.set_track(7)
	$AnimationPlayer.play("ease_in")


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		$AnimationPlayer.play("ease_out")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ease_out":
		if counter == 1:
			$CanvasLayer/CanvasModulate/first.show()
			$AnimationPlayer.play("ease_in")
			counter += 1
		elif counter == 2:
			$CanvasLayer/CanvasModulate/first.hide()
			$CanvasLayer/CanvasModulate/second.show()
			$AnimationPlayer.play("ease_in")
			counter += 1
		elif counter == 3:
			$CanvasLayer/CanvasModulate/second.hide()
			$CanvasLayer/CanvasModulate/third.show()
			$AnimationPlayer.play("ease_in")
			counter += 1
		elif counter == 4:
			$CanvasLayer/CanvasModulate/third.hide()
			$CanvasLayer/CanvasModulate/fourth.show()
			$AnimationPlayer.play("ease_in")
			counter += 1
		else:
			LevelController.load_menu()
