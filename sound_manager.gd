extends Node

@onready var music_player = $AudioStreamPlayer
var current_music_path: String = ""

func play_audio(music: AudioStream):
	if music_player.playing and music.resource_path == current_music_path:
		print("Already playing:", current_music_path)
		return
	current_music_path = music.resource_path
	music_player.stream = music
	music_player.play()
	print("Now playing:", current_music_path)
