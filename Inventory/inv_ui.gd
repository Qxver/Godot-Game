extends Control

@onready var slots : Array =  $NinePatchRect/Inv/GridContainer.get_children()

func _ready():
	update_slots()
	hide()

func update_slots():
	for i in range (min(PlayerStats.inventory.size(), slots.size())):
		slots[i].update(PlayerStats.inventory[i])

func resume():
	get_tree().paused = false
	$AnimatedSprite2D.stop()
	InputMap.load_from_project_settings()
	hide()
 
func pause():
	InputMap.action_erase_events("esc")
	%Dmg_val.text = str(PlayerStats.damage)
	%Ats_val.text = str(PlayerStats.attack_speed)
	%Hp_val.text = str(int(PlayerStats.health)) + "/" + str(PlayerStats.max_hp)
	%Def_val.text = str(PlayerStats.defence)
	update_slots()
	$AnimatedSprite2D.play("default")
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
