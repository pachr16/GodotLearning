extends KinematicBody2D

var score : int = 0;

var speed : int = 200;
var jumpForce : int = 600;
var gravity : int = 800;
var velocity : Vector2 = Vector2();

# onready delays initialization of var until the sprite is found
onready var sprite : Sprite = $Player_Idle
onready var ui : Node = get_node("/root/MainScene/CanvasLayer/UI")
onready var audioPlayer : Node = get_node("/root/MainScene/Camera2D/AudioPlayer")

func _physics_process(delta):
	velocity.x = 0
	
	# movement
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		
	# applying the new velocity to the player
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# gravity and jumping
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce
	
	# sprite direction
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
		
	
func die():
	get_tree().reload_current_scene()
	
func collectCoin(val):
	score += val
	ui.setScoreText(score)
	audioPlayer.playCoinSFX()
