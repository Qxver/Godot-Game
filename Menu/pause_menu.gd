extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().pause:
		resume()

func _on_resume_pressed():
	resume()

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menu/options_menu.tscn")

func _on_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
