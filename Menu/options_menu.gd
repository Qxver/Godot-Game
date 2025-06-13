extends Control

func _on_back_pressed() -> void:
	await get_tree().change_scene_to_file("res://Menu/menu.tscn")
