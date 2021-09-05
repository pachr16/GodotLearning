extends KinematicBody2D

# base stats
var maxHP : int = 15
var currentHP : int = 15
var moveSpeed : int = 250
var damage : int = 1
var interactRange : int = 80

# currency
var gold : int = 0

# leveling
var currentLevel : int = 1
var currentXP : int = 0
var xpToNextLevel : int = 50
var xpToLevelIncreaseRate : float = 1.2

# movement
var velocity : Vector2 = Vector2()
var facingDirection : Vector2 = Vector2()

# components
onready var rayCast = get_node("RayCast2D")
onready var animation = get_node("AnimatedSprite")
onready var ui = get_node("/root/MainScene/CanvasLayer/UI")

func _ready():
	ui.update_level_text(currentLevel)
	ui.update_healthbar(currentHP, maxHP)
	ui.update_xpbar(currentXP, xpToNextLevel)
	ui.update_gold_text(gold)
	

# called every frame (delta is time between frames)
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact()


func try_interact():
	rayCast.cast_to = facingDirection * interactRange
	if rayCast.is_colliding():
		if rayCast.get_collider() is KinematicBody2D:
			rayCast.get_collider().take_damage(damage)
		elif rayCast.get_collider().has_method("on_interact"):
			rayCast.get_collider().on_interact(self)
		
	

# called every second
func _physics_process(delta):
	velocity = Vector2()
	
	# inputs
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		facingDirection = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		facingDirection = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		facingDirection = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		facingDirection = Vector2(1, 0)
	
	# normalize to prevent magnitude of diagonal movement being larger
	velocity = velocity.normalized()
	
	# apply movements
	move_and_slide(velocity * moveSpeed)
	
	manage_animations()


func manage_animations():
	if velocity.x > 0:
		play_animation("MoveRight")
	elif velocity.x < 0:
		play_animation("MoveLeft")
	elif velocity.y > 0:
		play_animation("MoveDown")
	elif velocity.y < 0:
		play_animation("MoveUp")
	elif facingDirection.x == 1:
		play_animation("IdleRight")
	elif facingDirection.x == -1:
		play_animation("IdleLeft")
	elif facingDirection.y == 1:
		play_animation("IdleDown")
	elif facingDirection.y == -1:
		play_animation("IdleUp")
	
func give_xp(givenXP):
	currentXP += givenXP
	if currentXP >= xpToNextLevel:
		levelup()
	ui.update_xpbar(currentXP, xpToNextLevel)

func heal(healed):
	currentHP += healed
	if currentHP > maxHP:
		currentHP = maxHP
	ui.update_healthbar(currentHP, maxHP)

func levelup():
	var overflow = currentXP - xpToNextLevel
	xpToNextLevel *= xpToLevelIncreaseRate
	currentXP = overflow
	currentLevel += 1
	maxHP += 15
	heal(maxHP)
	ui.update_healthbar(currentHP, maxHP)
	ui.update_xpbar(currentXP, xpToNextLevel)
	ui.update_level_text(currentLevel)

func give_gold(amount):
	gold += amount
	ui.update_gold_text(gold)

func play_animation(animation_name):
	if animation.animation != animation_name:
		animation.play(animation_name)

func take_damage(damageTaken):
	currentHP -= damageTaken
	if currentHP <= 0:
		die()
	ui.update_healthbar(currentHP, maxHP)

func die():
	# restart the game when player dies
	get_tree().reload_current_scene()
	
