extends Node

@onready var music: AudioStreamPlayer = $music

func start():
	music.play()
func stop():
	music.stop()
