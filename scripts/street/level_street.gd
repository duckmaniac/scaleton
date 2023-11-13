extends Node


var debug = true
var is_playing_football = false

var lose_phrases = ["LET'S TRY AGAIN!", "DON'T GIVE UP!", "KEEP GOING!",
"STAY STRONG!", "BELIEVE IN YOURSELF!", "EVERY STEP COUNTS!"]
var lose_counter = 0


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
		$scaleton.contact_monitor = true


func _process(_delta):
	if is_playing_football:
		$scaleton.position.x = clamp($scaleton.position.x, 501, 591)


func _on_d_with_boney_dialog_ended():
	start_football_game()
	

func start_football_game():
	$scaleton.can_move = false
	$dimmer.light_off()
	await get_tree().create_timer(2).timeout
	is_playing_football = true
	$scaleton.teleport(Vector2(525, 779))
	$friend.position = Vector2(1329, 559)
	$friend.state = $friend.State.STATE_PLAY
	$neighbours/footbal_game/ball.reset_state = true
	$dimmer.light_on()
	$scaleton.can_move = true
	$neighbours/footbal_game/playground.visible = true


func _on_left_goal_body_entered(body):
	if is_playing_football and body.is_in_group("ball"):
		is_playing_football = false
		$dimmer/AnimationPlayer/Label.text = lose_phrases[lose_counter % lose_phrases.size()]
		lose_counter += 1;
		start_football_game()


func _on_right_goal_body_entered(body):
	if is_playing_football and body.is_in_group("ball"):
		is_playing_football = false
		$neighbours/footbal_game/ball.is_forced_move = false
		$friend.state = $friend.State.STATE_DIALOG
		$neighbours/footbal_game/left_goal.monitoring = false
		set_deferred("$neighbours/footbal_game/right_goal.monitoring", false)
		$neighbours/interactions/d_after_game/CollisionShape2D.position = $scaleton.position


func _on_d_after_game_dialog_ended():
	$friend.state = $friend.State.STATE_WALKING
	$friend.point_to_walk = Vector2(2137, 569)
	$scaleton.interactable_object = null
