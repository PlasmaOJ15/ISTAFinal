extends Node2D

# Called when the node enters the scene tree for the first time.
# Ensures that museum music plays in museum
func _ready() -> void:
	Audio.changeAudio("music")
