extends Node2D
@onready var head: AnimatedSprite2D = $head
@onready var body: AnimatedSprite2D = $body
@onready var hands: AnimatedSprite2D = $hands
var canTalk = false
var talking = false
@onready var info: CanvasLayer = $info
@onready var label: Label = $info/Label

# Plays idle animation and changes text when seen experience
func _ready() -> void:
	idle()
	if Global.experienced:
		label.text = "Welcome back. I hope you enjoyed the experience.\nTo the left you can find the archives, and to the right\nyou can see all the collages. Use + or - to zoom in or out"

# Play talking sprites
func talk():
	head.play("talk")
	body.play("talk")
	hands.play("talk")

# Play idle sprites
func idle():
	head.play("idle")
	body.play("idle")
	hands.play("idle")

# If player interacts with Curator, show text and talk
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
		
# When player comes near Curator
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Protag":
		canTalk = true

# When player walks away from curator
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Protag":
		canTalk = false
