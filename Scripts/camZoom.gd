extends Node2D
@onready var protag: CharacterBody2D = $Protag

#Allows for camera zoom in rooms that need it
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoomIn"):
		protag.zoomIn()
	elif Input.is_action_just_pressed("zoomOut"):
		protag.zoomOut()
