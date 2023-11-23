extends StaticBody2D


func interact(player):
	player.speed = 100
	position.x = player.position.x - 675
