extends AudioStreamPlayer2D

var coinSFX = preload("res://Audio/coin.tres")

func playCoinSFX():
	stream = coinSFX
	play()
