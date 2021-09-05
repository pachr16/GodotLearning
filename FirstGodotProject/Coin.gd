extends Area2D

# export means value is editable for single instances in inspector
export var val : int = 1
var rotSpeed : float = 45

func _process(delta):
	rotation_degrees += rotSpeed * delta


func _on_Coin_body_entered(body):
	if body.name == "Player":
		body.collectCoin(val)
		queue_free()
