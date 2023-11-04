extends StaticBody2D

var phrases = [
	"\"No Pun Intended: Volume Too\" ohh love this book!",
	"\"Quantum Psychology\" why my mom even bought it?",
	"\"Archery is for dummies\", sigh, my father dreams of me becoming an archer"
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
