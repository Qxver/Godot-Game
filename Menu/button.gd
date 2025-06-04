extends Button
var click_sound = preload("res://Assets/Sound/Effects/mixkit-modern-technology-select-3124.wav")  


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_audio(click_sound)
	grab_focus()
