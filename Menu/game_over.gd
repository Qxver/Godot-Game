extends Control

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	$AnimationPlayer.play_backwards("go_blur")
	await $AnimationPlayer.animation_finished
	hide()
		
func pause():
	show()
	InputMap.action_erase_events("esc")
	get_tree().paused = true
	$AnimationPlayer.play("go_blur")
	
func _on_restart_pressed():
	InputMap.load_from_project_settings()
	PlayerStats.player_base_stats(PlayerStats.character_id)
	resume()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")
	
func _on_main_menu_pressed():
	InputMap.load_from_project_settings()
	resume()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
