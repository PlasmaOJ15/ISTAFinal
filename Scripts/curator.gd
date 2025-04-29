extends Node2D
@onready var head: AnimatedSprite2D = $head
@onready var body: AnimatedSprite2D = $body
@onready var hands: AnimatedSprite2D = $hands
var canTalk = false
var talking = false
@onready var info: CanvasLayer = $info
@onready var label: Label = $info/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	head.play("idle")
	body.play("idle")
	hands.play("idle")

func talk():
	head.play("talk")
	body.play("talk")
	hands.play("talk")
	
func idle():
	head.play("idle")
	body.play("idle")
	hands.play("idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and canTalk and !talking:
		Global.playerLocked = true
		talking = true
		talk()
		info.visible = true
	elif Input.is_action_just_pressed("interact") and talking:
		info.visible = false
		Global.playerLocked = false
		talking = false
		idle()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Protag":
		canTalk = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Protag":
		canTalk = false
