extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/character_selection.tscn")


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/shop.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/options_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
	

# background music
func _ready() -> void:
	SoundManager.Soundtrack1Progress = 0.0
	SoundManager.Soundtrack2Progress = 0.0
	SoundManager.play_soundtrack1() # menu soundtrack
