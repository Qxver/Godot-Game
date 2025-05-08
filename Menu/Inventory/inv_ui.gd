extends Control

func _ready():
	hide()

func resume():
	get_tree().paused = false
	##$AnimationPlayer.play_backwards("blur_inv")
	#await $AnimationPlayer.animation_finished
	InputMap.load_from_project_settings()
	hide()
	 
func pause():
	InputMap.action_erase_events("esc")
	show()
	get_tree().paused = true
	#$AnimationPlayer.play("blur_inv")

func testInv():
	if Input.is_action_just_pressed("inv") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("inv") and get_tree().paused:
		resume()

func _process(_delta):
	testInv()
