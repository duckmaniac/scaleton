extends Interactable

@export var phrases: Array[String] = []
@export var one_off = false
@export var additional_sfx_phrase = 0
@export var additional_sfx: AudioStreamPlayer = null

signal dialog_ended

var type_sound = preload("res://assets/sfx/type.mp3")
var type_end_sound = preload("res://assets/sfx/type_end.mp3")

var count_phrases = 0
var count_chars = 1
var current_phrase = null
var is_dialog_showing = false
var timer = null

var is_typing = false
var has_been_interacted = false


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
			$AudioStreamPlayer.play()
		elif count_chars == current_phrase.length() - 1:
			$AudioStreamPlayer.stream = type_end_sound
			$AudioStreamPlayer.play()
		$CanvasLayer/Label.text = current_phrase.substr(0, count_chars)
		if count_chars < current_phrase.length():
			start_timer()
		else:
			is_typing = false


func show_next_phrase():
	if count_phrases == additional_sfx_phrase and additional_sfx != null:
		additional_sfx.play()
	is_typing = true
	$CanvasLayer/Label.text = ""
	current_phrase = phrases[count_phrases]
	count_phrases += 1
	count_chars = 1
	$AudioStreamPlayer.stream = type_sound
	$AudioStreamPlayer.play()
	start_timer()


func interact():
	if one_off and has_been_interacted: return
	
	if is_typing:
		$CanvasLayer/Label.text = current_phrase
		$AudioStreamPlayer.stream = type_end_sound
		$AudioStreamPlayer.play()
		is_typing = false
		return
		
	if not is_dialog_showing:
		player.can_move = false
		is_dialog_showing = true
		$CanvasLayer.show()
	if count_phrases != phrases.size():
		show_next_phrase()
	else:
		$CanvasLayer.hide()
		count_phrases = 0
		is_dialog_showing = false
		player.can_move = true
		has_been_interacted = true
		emit_signal("dialog_ended")
