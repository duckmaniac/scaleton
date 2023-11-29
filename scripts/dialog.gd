extends Interactable

signal phrase_ended

@export var phrases: Array[String] = []
@export var additional_sfx_phrase = 0
@export var additional_sfx: AudioStreamPlayer = null

var type_sound = preload("res://assets/sfx/type.mp3")
var type_end_sound = preload("res://assets/sfx/type_end.mp3")
var count_phrases = 0
var count_chars = 1
var current_phrase = null
var is_dialog_showing = false
var timer = null
var is_typing = false


func _ready():
	timer = Timer.new()
	timer.wait_time = 0.04
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)


func start_timer():
	timer.start()


func _on_Timer_timeout():
	if is_dialog_showing and is_typing:
		count_chars += 1
		if current_phrase[count_chars-1] == " ":
			$typing_sfx.play()
		if count_chars == current_phrase.length():
			end_typing()
		$CanvasLayer/Label.text = current_phrase.substr(0, count_chars)
		if count_chars < current_phrase.length():
			start_timer()


func end_typing():
	$CanvasLayer/Label.text = current_phrase
	$typing_sfx.stream = type_end_sound
	$typing_sfx.play()
	is_typing = false
	

func interact():
	if is_typing:
		end_typing()
		return
		
	if not is_dialog_showing: 
		if count_phrases == additional_sfx_phrase and additional_sfx != null:
			additional_sfx.play()
		player.can_move = false
		is_dialog_showing = true
		is_typing = true
		current_phrase = phrases[count_phrases % phrases.size()]
		$CanvasLayer.show()
		$typing_sfx.stream = type_sound
		$typing_sfx.play()
		start_timer()
	else:
		$CanvasLayer.hide()
		$CanvasLayer/Label.text = ""
		count_phrases += 1
		count_chars = 1
		is_dialog_showing = false
		is_typing = false
		player.can_move = true
		emit_signal("phrase_ended")
