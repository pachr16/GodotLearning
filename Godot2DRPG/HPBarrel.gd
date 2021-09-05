extends StaticBody2D

export var HPToGive : int = 5

func on_interact(target):
	target.heal(HPToGive)
	queue_free()
	
