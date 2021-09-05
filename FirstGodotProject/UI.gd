extends Control

onready var scoreText = get_node("Score")

func _ready():
	scoreText.text = "0"
	
func setScoreText(score):
	
	scoreText.text = str(score)
