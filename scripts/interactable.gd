# BE CAREFUL: if you override some function,
# don't forget to add super() call

class_name Interactable
extends Area2D


@export var auto_interact: bool = false
@export var interaction_limit: int = 0

var player = null
var interaction_counter = 0


func _init():
	body_entered.connect(_on_self_body_entered)
	body_exited.connect(_on_self_body_exited)


func _process(_delta):
	if not can_interact(): return
	if Input.is_action_just_pressed("interact"): 
		interaction_counter += 1
		interact()


func _on_self_body_entered(body):
	if not body.is_in_group("player"): return
	player = body
	if auto_interact and can_interact(): 
		interaction_counter += 1
		interact()


func _on_self_body_exited(body):
	if not body.is_in_group("player"): return
	player = null


func can_interact():
	if player == null: return false
	if interaction_limit != 0 and interaction_counter == interaction_limit: return false
	return true


func interact():
	pass
