extends Area2D
@export var sceneName = "res://Scenes/gallery.tscn"
@export var roomName = "The Gallery"
var canInteract = false
@onready var label: Label = $Label

# Sets name text from input
func _ready() -> void:
	label.visible = false
	label.text = "Enter " + roomName + "?"


# If player interacts, teleport
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and canInteract:
		get_tree().change_scene_to_file(sceneName)

# When player leaves teleport area
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Protag":
		canInteract = false
		label.visible = false

# When player enters teleport area
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protag":
		canInteract = true
		label.visible = true
