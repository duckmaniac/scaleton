extends Node


var has_been_shown = false
var has_been_hidden = false


func _on_note_view_closed():
	if has_been_hidden or has_been_shown: return
	has_been_shown = true
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("show_hint")


func _on_highlight_shown():
	if has_been_hidden: return
	has_been_hidden = true
	if has_been_shown:
		$AnimationPlayer.play("hide_hint")
