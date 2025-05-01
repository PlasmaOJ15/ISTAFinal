extends Node
@onready var music: AudioStreamPlayer = $music
@onready var staticSound: AudioStreamPlayer = $static

# Changes audio when called
func changeAudio(type):
	if type == "static":
		music.stop()
		staticSound.play()
	elif type == "music" and !music.playing:
		staticSound.stop()
		music.play()
