extends Interactable


signal playing
signal secret_door_opened

var secret_door_sfx = preload("res://assets/sfx/secret_door.mp3")
var is_secret_door_opened = false

var first_play = true
var is_playing = false
var has_notes = false

var music_scale = ["do", "re", "mi", "fa", "sol", "la", "ti", "do_high",
			"ti", "la", "sol", "fa", "mi", "re", "do"]
var current_note = null
var num_of_match_notes = 0

var hint_has_been_hidden = false
var hint_has_been_shown = false


func _process(delta):
	super(delta)
	if not is_playing: return
	
	current_note = null
	if Input.is_action_just_pressed("do"):
		current_note = "do"
		$CanvasLayer/pressed_keys/do.show()
		$CanvasLayer/sound/do.play()
	if Input.is_action_just_pressed("do#"):
		current_note = "do#"
		$'CanvasLayer/pressed_keys/do#'.show()
		$'CanvasLayer/sound/do#'.play()
	if Input.is_action_just_pressed("re"):
		current_note = "re"
		$CanvasLayer/pressed_keys/re.show()
		$CanvasLayer/sound/re.play()
	if Input.is_action_just_pressed("re#"):
		current_note = "re#"
		$'CanvasLayer/pressed_keys/re#'.show()
		$'CanvasLayer/sound/re#'.play()
	if Input.is_action_just_pressed("mi"):
		current_note = "mi"
		$CanvasLayer/pressed_keys/mi.show()
		$CanvasLayer/sound/mi.play()
	if Input.is_action_just_pressed("fa"):
		current_note = "fa"
		$CanvasLayer/pressed_keys/fa.show()
		$CanvasLayer/sound/fa.play()
	if Input.is_action_just_pressed("fa#"):
		current_note = "fa#"
		$'CanvasLayer/pressed_keys/fa#'.show()
		$'CanvasLayer/sound/fa#'.play()
	if Input.is_action_just_pressed("sol"):
		current_note = "sol"
		$CanvasLayer/pressed_keys/sol.show()
		$CanvasLayer/sound/sol.play()
	if Input.is_action_just_pressed("sol#"):
		current_note = "sol#"
		$'CanvasLayer/pressed_keys/sol#'.show()
		$'CanvasLayer/sound/sol#'.play()
	if Input.is_action_just_pressed("la"):
		current_note = "la"
		$CanvasLayer/pressed_keys/la.show()
		$CanvasLayer/sound/la.play()
	if Input.is_action_just_pressed("la#"):
		current_note = "la#"
		$'CanvasLayer/pressed_keys/la#'.show()
		$'CanvasLayer/sound/la#'.play()
	if Input.is_action_just_pressed("ti"):
		current_note = "ti"
		$CanvasLayer/pressed_keys/ti.show()
		$CanvasLayer/sound/ti.play()
	if Input.is_action_just_pressed("do_high"):
		current_note = "do_high"
		$CanvasLayer/pressed_keys/do_high.show()
		$CanvasLayer/sound/do_high.play()
		
	if Input.is_action_just_released("do"):
		$CanvasLayer/pressed_keys/do.hide()
		$CanvasLayer/sound/do.stop()
	if Input.is_action_just_released("do#"):
		$'CanvasLayer/pressed_keys/do#'.hide()
		$'CanvasLayer/sound/do#'.stop()
	if Input.is_action_just_released("re"):
		$CanvasLayer/pressed_keys/re.hide()
		$CanvasLayer/sound/re.stop()
	if Input.is_action_just_released("re#"):
		$'CanvasLayer/pressed_keys/re#'.hide()
		$'CanvasLayer/sound/re#'.stop()
	if Input.is_action_just_released("mi"):
		$CanvasLayer/pressed_keys/mi.hide()
		$CanvasLayer/sound/mi.stop()
	if Input.is_action_just_released("fa"):
		$CanvasLayer/pressed_keys/fa.hide()
		$CanvasLayer/sound/fa.stop()
	if Input.is_action_just_released("fa#"):
		$'CanvasLayer/pressed_keys/fa#'.hide()
		$'CanvasLayer/sound/fa#'.stop()
	if Input.is_action_just_released("sol"):
		$CanvasLayer/pressed_keys/sol.hide()
		$CanvasLayer/sound/sol.stop()
	if Input.is_action_just_released("sol#"):
		$'CanvasLayer/pressed_keys/sol#'.hide()
		$'CanvasLayer/sound/sol#'.stop()
	if Input.is_action_just_released("la"):
		$CanvasLayer/pressed_keys/la.hide()
		$CanvasLayer/sound/la.stop()
	if Input.is_action_just_released("la#"):
		$'CanvasLayer/pressed_keys/la#'.hide()
		$'CanvasLayer/sound/la#'.stop()
	if Input.is_action_just_released("ti"):
		$CanvasLayer/pressed_keys/ti.hide()
		$CanvasLayer/sound/ti.stop()
	if Input.is_action_just_released("do_high"):
		$CanvasLayer/pressed_keys/do_high.hide()
		$CanvasLayer/sound/do_high.stop()
	
	if current_note == null: return
	if music_scale[num_of_match_notes] == current_note:
		num_of_match_notes += 1
		if has_notes: $CanvasLayer/highlight/notes.size.x += 5.4
	elif music_scale[0] == current_note:
		num_of_match_notes = 1
		if has_notes: $CanvasLayer/highlight/notes.size.x = 5.4
	else:
		num_of_match_notes = 0
		if has_notes: $CanvasLayer/highlight/notes.size.x = 0
	if num_of_match_notes == music_scale.size():
		num_of_match_notes = 0
		if is_secret_door_opened: return;
		emit_signal("secret_door_opened")
		is_secret_door_opened = true;
		close_game()
		$CanvasLayer/pressed_keys/do.hide()
		$AnimationPlayer.play("secret_door_opening")
		$AudioStreamPlayer.stream = secret_door_sfx
		$AudioStreamPlayer.play()
		
func interact():
	emit_signal("playing")
	if not is_playing:
		AudioServer.set_bus_effect_enabled(2, 0, true)
		is_playing = true
		player.can_move = false
		$CanvasLayer.show()
		if has_notes and first_play:
			$AudioStreamPlayer.play()
			first_play = false
			await get_tree().create_timer(1).timeout
			if not (hint_has_been_hidden or hint_has_been_shown):
				hint_has_been_shown = true
				$AnimationPlayer.play("show_hint")
	else:
		player.can_move = true
		close_game()


func close_game():
	AudioServer.set_bus_effect_enabled(2, 0, false)
	is_playing = false
	$CanvasLayer.hide()


func _on_highlight_shown():
	if not is_playing or hint_has_been_hidden: return
	hint_has_been_hidden = true
	if hint_has_been_shown:
		$AnimationPlayer.play("hide_hint")
