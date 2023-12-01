extends Interactable


@export_range(0, 4) var frame = 0
var can_be_eaten = false


func _ready():
	$star.frame = frame
	

func interact():
	if can_be_eaten: visible = false
