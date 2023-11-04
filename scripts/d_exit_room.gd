extends StaticBody2D

var phrases = [
	"Nope, can't leave without my clothes. I got some 'bare bones' to cover up!",
	"I can't go anywhere without my wardrobe. I need something to 'dress my skeleton' in!",
	"Leaving without my attire? Not a chance! I've got 'basic bones' to adorn!"
]
var count = 0
var is_dialog_showing = false

func interact(player):
	if not is_dialog_showing and not player.is_dressed_in_street_clothes():
		is_dialog_showing = true
		$CanvasLayer/RichTextLabel.text = phrases[count % phrases.size()]
		$CanvasLayer.show()
		await get_tree().create_timer(3.5).timeout
		$CanvasLayer.hide()
		count += 1
		is_dialog_showing = false
