extends Area2D


export var speed : int = 100
export var movedistance : int = 100

onready var startX : int = position.x
onready var targetX : int = startX + movedistance

func _process(delta):
	position.x = move(position.x, targetX, speed * delta)
	
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + movedistance
		else:
			targetX = startX

func move(pos, destination, step):
	var new = pos
	
	# towards positive
	if new < destination:
		new += step
		if new > destination:
			new = destination
	
	# towards negative
	else:
		new -= step
		if new < destination:
			new = destination
	
	return new


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()
	
