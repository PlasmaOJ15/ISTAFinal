extends CharacterBody2D

# get game objects
@onready var player_sprite: AnimatedSprite2D = $playerSprite
@onready var camera: Camera2D = $Camera
@export var leftClamp = 0
@export var rightClamp = 0
@export var upClamp = 0
@export var downClamp = 0
const SPEED = 250.0
var can_move = true

func _ready() -> void:
	camera.limit_left = leftClamp
	camera.limit_right = rightClamp
	camera.limit_top = upClamp
	camera.limit_bottom = downClamp

func _physics_process(_delta: float) -> void:
	if Global.playerLocked != true:
		move_state()
		
func move_state():
	var direction_x := Input.get_axis("left", "right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction_y := Input.get_axis("up", "down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if velocity.x > 0:
		player_sprite.flip_h = true
	elif velocity.x < 0:
		player_sprite.flip_h = false
	
	if direction_x and direction_y:
		velocity = velocity*0.75
	
	if velocity.y != 0 or velocity.x!=0:
		player_sprite.play("walk")
	else:
		player_sprite.play('idle')
	move_and_slide()

func disable_movement(boolean):
	can_move = boolean
