extends Node2D
@export var resource: Texture
@export var artistName = "Cami"
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var sprite_2d: TextureRect = $CanvasLayer/Sprite2D
@onready var label: Label = $Label
@onready var chest: AnimatedSprite2D = $chest

var canInteract = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = resource
	label.text = "View " + artistName + "'s Images?"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and canInteract:
		if sprite_2d.visible:
			sprite_2d.visible = false
			Global.playerLocked = false
			chest.play("closed")
		else:
			sprite_2d.visible = true
			Global.playerLocked = true
			chest.play("open")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Protag":
		canInteract = false
		label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protag":
		canInteract = true
		label.visible = true
