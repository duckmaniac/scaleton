extends StaticBody2D

signal to_coridor

var phrases = [
	"Nope, can't leave without my clothes. I got some 'bare bones' to cover up!",
	"I can't go anywhere without my wardrobe. I need something to 'dress my skeleton' in!",
	"Leaving without my attire? Not a chance! I've got 'basic bones' to adorn!"
]
var count = 0
var is_dialog_showing = false

func interact(player):
	if is_dialog_showing: return
	
	if player.is_dressed_in_street_clothes():
		player.set_deferred("position", Vector2(1442, 1721))
		emit_signal("to_coridor")
	else:
		is_dialog_showing = true
		$CanvasLayer/RichTextLabel.text = phrases[count % phrases.size()]
		$CanvasLayer.show()
		await get_tree().create_timer(3.5).timeout
		$CanvasLayer.hide()
		count += 1
		is_dialog_showing = false
