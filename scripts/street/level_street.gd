extends Node

var debug = true
var is_playing_football = false

func _ready():
	MusicController.set_track(1)
	MusicController.play_music()
	
	# intro
	if not debug:
		$scaleton.contact_monitor = false
		$scaleton.can_move = false
		$neighbours/intro.visible = true
		await get_tree().create_timer(3.2).timeout
		$neighbours/intro/author.visible = true
		await get_tree().create_timer(3.8).timeout
		$neighbours/intro.visible = false
		$scaleton.can_move = true
		$scaleton.contact_monitor = true
		
func _process(_delta):
	if is_playing_football:
		$scaleton.position.x = clamp($scaleton.position.x, 501, 591)


func _on_d_with_boney_dialog_ended():
	$dimmer.light_off()
	await get_tree().create_timer(0.5).timeout
	is_playing_football = true
	$scaleton.teleport(Vector2(525, 779))
	$friend.position = Vector2(1329, 559)
	$friend.state = $friend.State.STATE_PLAY
	$dimmer.light_on()
