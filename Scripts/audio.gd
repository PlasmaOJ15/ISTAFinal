extends Node
@onready var music: AudioStreamPlayer = $music
@onready var staticSound: AudioStreamPlayer = $static

func changeAudio(type):
	if type == "static":
		music.stop()
		staticSound.play()
	elif type == "music" and !music.playing:
		staticSound.stop()
		music.play()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
