extends Control


func _ready():
	hide()
	$AnimationPlayer.play("RESET")
	

func resume():
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	InputMap.load_from_project_settings()
	hide()
	
func pause():
	InputMap.action_erase_events("inv")
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menu/options_menu.tscn")

func _on_main_menu_pressed():
	PlayerStats.save_game(PlayerStats.coins)
	resume()
	await resume()
	MenuBackground.visible = true
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_quit_pressed():
	PlayerStats.save_game(PlayerStats.coins)
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func _process(_delta):
	testEsc()
