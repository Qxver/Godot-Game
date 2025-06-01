extends Node

@onready var soundtrack = $Soundtrack
@onready var pickup_sound = $PickupSound

var current_music_path: String = ""

func play_soundtrack(music: AudioStream):
	if soundtrack.playing and music.resource_path == current_music_path:
		return
	current_music_path = music.resource_path
	soundtrack.stream = music
	soundtrack.play()

func play_audio(audio: AudioStream):
	pickup_sound.stream = audio
	pickup_sound.play()
