extends Node

@onready var soundtrack = $Soundtrack
@onready var sound_effect = $SoundEffects
var soundtrack1 = load("res://Assets/Sound/Soundtrack/Main_menu_track.wav")
var soundtrack2 = load("res://Assets/Sound/Soundtrack/Gameplay_track.wav")
var Soundtrack1Progress = 0.0
var Soundtrack2Progress = 0.0

var current_music_path: String = ""
	

func play_soundtrack1():
	if soundtrack.playing and soundtrack1.resource_path == current_music_path:
		return
	current_music_path = soundtrack1.resource_path
	soundtrack.stream = soundtrack1
	soundtrack.play(Soundtrack1Progress)
	
	
func play_soundtrack2():
	if soundtrack.playing and soundtrack2.resource_path == current_music_path:
		return
	current_music_path = soundtrack2.resource_path
	soundtrack.stream = soundtrack2
	soundtrack.play(Soundtrack2Progress)


func play_audio(audio: AudioStream):
	sound_effect.stream = audio
	sound_effect.play()
