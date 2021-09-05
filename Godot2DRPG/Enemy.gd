extends KinematicBody2D

# base stats
export var maxHP : int = 5
var currentHP : int = maxHP
export var moveSpeed : int = 150
export var damage : int = 1
export var attackRate : float = 1.0
var attackRange : int = 80
var chaseRange : int = 400

# "loot"
export var xpToGive : int = 30

# components
onready var timer = get_node("Timer")
onready var player = get_node("/root/MainScene/Player")

func _ready():
	timer.wait_time = attackRate
	timer.start()

func _physics_process(delta):
	var distance = position.distance_to(player.position)
	
	if distance > attackRange and distance < chaseRange:
		# normalize makes magnitude of the vector 1
		var velocity = (player.position - position).normalized()
		move_and_slide(velocity * moveSpeed)
		
	


func _on_Timer_timeout():
	if position.distance_to(player.position) <= attackRange:
		player.take_damage(damage)
	

func take_damage(damageTaken):
	currentHP -= damageTaken
	if currentHP <= 0:
		die()

func die():
	player.give_xp(xpToGive)
	queue_free()
