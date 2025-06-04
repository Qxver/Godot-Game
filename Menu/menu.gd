extends Control
var click_sound = preload("res://Assets/Sound/Effects/mixkit-modern-technology-select-3124.wav")  


func _on_play_pressed() -> void:
	SoundManager.play_audio(click_sound)
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Menu/character_selection.tscn")


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/shop.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/options_menu.tscn")


func _on_exit_pressed() -> void:
	SoundManager.play_audio(click_sound)
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
	

# background music
func _ready() -> void:
	SoundManager.Soundtrack1Progress = 0.0
	SoundManager.Soundtrack2Progress = 0.0
	SoundManager.play_soundtrack1() # menu soundtrack
