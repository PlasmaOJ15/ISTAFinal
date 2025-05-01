extends CharacterBody2D

# get game objects
@onready var player_sprite: AnimatedSprite2D = $playerSprite
@onready var camera: Camera2D = $Camera
@onready var shadow: Sprite2D = $Camera/CanvasLayer/shadow

@export var leftClamp = 0
@export var rightClamp = 0
@export var upClamp = 0
@export var downClamp = 0
@export var hasShadow = false
const SPEED = 250.0
var can_move = true
var zoomLevel = 2

# Sets camera limits
func _ready() -> void:
	if hasShadow:
		shadow.visible = true
	camera.limit_left = leftClamp
	camera.limit_right = rightClamp
	camera.limit_top = upClamp
	camera.limit_bottom = downClamp

# Allow movement when not locked
func _physics_process(_delta: float) -> void:
	if Global.playerLocked != true:
		move_state()
	else:
		player_sprite.play('idle')
	if Input.is_action_just_pressed("DEBUG"):
		Global.experienced = true
		get_tree().change_scene_to_file("res://Scenes/gallery.tscn")

# Moves player and sets sprites
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

# Zoom in the camera
func zoomIn():
	if zoomLevel == 2:
		zoomLevel = 1
		camera.zoom = Vector2(2.0,2.0)
	elif zoomLevel == 3:
		zoomLevel = 2
		camera.zoom = Vector2(1.0,1.0)
	elif zoomLevel == 4:
		zoomLevel = 3
		camera.zoom = Vector2(0.5,0.5)

# Zoom out the camera
func zoomOut():
	if zoomLevel == 2:
		zoomLevel = 3
		camera.zoom = Vector2(0.5,0.5)
	elif zoomLevel == 1:
		zoomLevel = 2
		camera.zoom = Vector2(1.0,1.0)
	elif zoomLevel == 3:
		zoomLevel = 4
		camera.zoom = Vector2(0.3,0.3)

# Disable player movement
func disable_movement(boolean):
	can_move = boolean
