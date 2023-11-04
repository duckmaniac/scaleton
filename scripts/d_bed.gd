extends StaticBody2D

var phrases = [
	"No rest for the wicked... or for the skeletal!",
	"Why should I sleep? I'm bone-tired all the time!",
	"Dreams? Nah, I've been dead tired for centuries!"
]
var count = 0
var is_dialog_showing = false

func interact(_player):
	if not is_dialog_showing:
		is_dialog_showing = true
		$CanvasLayer/RichTextLabel.text = phrases[count % phrases.size()]
		$CanvasLayer.show()
		await get_tree().create_timer(3.5).timeout
		$CanvasLayer.hide()
		count += 1
		is_dialog_showing = false
