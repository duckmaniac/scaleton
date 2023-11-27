extends Interactable


@export var phrases = []

signal yes_chosen
signal no_chosen

var type_sound = preload("res://assets/sfx/type.mp3")
var type_end_sound = preload("res://assets/sfx/type_end.mp3")

var count_phrases = 0
var count_chars = 1
var current_phrase = null
var is_dialog_showing = false
var timer = null
var is_typing = false
var is_choice_showing = false
var chose = true


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
		if count_chars == current_phrase.length():
			end_typing()
		$CanvasLayer/Label.text = current_phrase.substr(0, count_chars)
		if count_chars < current_phrase.length():
			start_timer()	


func _process(delta):
	super(delta)
	if is_choice_showing:
		if Input.is_action_just_pressed("ui_left"):
			chose = true
			$CanvasLayer/left_choice.add_theme_constant_override("outline_size", 3)
			$CanvasLayer/right_choice.add_theme_constant_override("outline_size", 0)
			$CanvasLayer/left_choice.add_theme_font_size_override("font_size", 45)
			$CanvasLayer/right_choice.add_theme_font_size_override("font_size", 40)
		elif Input.is_action_just_pressed("ui_right"):
			chose = false
			$CanvasLayer/left_choice.add_theme_constant_override("outline_size", 0)
			$CanvasLayer/right_choice.add_theme_constant_override("outline_size", 3)
			$CanvasLayer/left_choice.add_theme_font_size_override("font_size", 40)
			$CanvasLayer/right_choice.add_theme_font_size_override("font_size", 45)


func show_choice():
	is_choice_showing = true
	$CanvasLayer/left_choice.show()
	$CanvasLayer/right_choice.show()


func hide_choice():
	is_choice_showing = false
	$CanvasLayer/left_choice.hide()
	$CanvasLayer/right_choice.hide()
	
	
func end_typing():
	$CanvasLayer/Label.text = current_phrase
	$AudioStreamPlayer.stream = type_end_sound
	$AudioStreamPlayer.play()
	show_choice()
	is_typing = false


func interact():
	if is_typing:
		end_typing()
		return
		
	if not is_dialog_showing: 
		player.can_move = false
		is_dialog_showing = true
		is_typing = true
		current_phrase = phrases[count_phrases % phrases.size()]
		$CanvasLayer.show()
		$AudioStreamPlayer.stream = type_sound
		$AudioStreamPlayer.play()
		start_timer()
	elif not is_choice_showing:
		show_choice()
	else:
		$CanvasLayer.hide()
		$CanvasLayer/Label.text = ""
		count_phrases += 1
		count_chars = 1
		is_dialog_showing = false
		is_typing = false
		player.can_move = true
		hide_choice()
		if chose:
			emit_signal("yes_chosen")
		else:
			emit_signal("no_chosen")
