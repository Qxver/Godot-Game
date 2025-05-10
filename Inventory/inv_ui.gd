extends Control

func _ready():
	hide()

func resume():
	get_tree().paused = false
	InputMap.load_from_project_settings()
	hide()
 
func pause():
	InputMap.action_erase_events("esc")
	%Dmg_val.text = str(PlayerStats.damage)
	%Ats_val.text = str(PlayerStats.attack_speed)
	%Hp_val.text = str(PlayerStats.health) + "/" + str(PlayerStats.max_hp)
	%Def_val.text = str(PlayerStats.defence)
	show()
	get_tree().paused = true

func testInv():
	if Input.is_action_just_pressed("inv") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("inv") and get_tree().paused:
		resume()

func _process(_delta):
	testInv()

func _on_exit_pressed():
	resume()
