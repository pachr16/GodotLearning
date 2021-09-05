extends StaticBody2D

export var goldToDrop : int = 5


func on_interact(target):
	target.give_gold(goldToDrop)
	queue_free()
