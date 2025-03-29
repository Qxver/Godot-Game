extends Control

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("go_blur")
	await $AnimationPlayer.animation_finished
	hide()
	
func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("go_blur")
	
func _on_restart_pressed():
	resume()
	get_tree().change_scene_to_file("res://game.tscn")
	
func _on_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
