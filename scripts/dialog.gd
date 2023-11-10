extends StaticBody2D

@export var phrases = []

var type_sound = preload("res://assets/sfx/type.mp3")
var type_end_sound = preload("res://assets/sfx/type_end.mp3")

var count_phrases = 0
var count_chars = 1
var current_phrase = null
var is_dialog_showing = false
var timer = null

func _ready():	
	timer = Timer.new()
	timer.wait_time = 0.04
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)

func start_timer():
	timer.start()

func _on_Timer_timeout():
	if is_dialog_showing:
		count_chars += 1
		if current_phrase[count_chars-1] == " ":	
			$AudioStreamPlayer.play()
		elif count_chars == current_phrase.length() - 1:
			$AudioStreamPlayer.stream = type_end_sound
			$AudioStreamPlayer.play()
		$CanvasLayer/Label.text = current_phrase.substr(0, count_chars)
		if count_chars < current_phrase.length():
			start_timer()
			

func interact(player):
	if not is_dialog_showing: 
		player.can_move = false
		is_dialog_showing = true
		current_phrase = phrases[count_phrases % phrases.size()]
		$CanvasLayer.show()
		$AudioStreamPlayer.stream = type_sound
		$AudioStreamPlayer.play()
		start_timer()
	else:
		$CanvasLayer.hide()
		$CanvasLayer/Label.text = ""
		count_phrases += 1
		count_chars = 1
		is_dialog_showing = false
		player.can_move = true
