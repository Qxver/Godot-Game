extends Control

@onready var slots : Array =  $NinePatchRect/Inv/GridContainer.get_children()

func _ready():
	connect_slots()
	update_slots()
	hide()

func connect_slots():
	for slot in slots:
		var callable = Callable(on_slot_pressed)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update_slots():
	for i in range(slots.size()):
		var slot = slots[i]
		if slot == null:
			continue 
		if i < PlayerStats.inventory.size():
			var inv_item: InvItems = PlayerStats.inventory[i]
			slot.update(inv_item)
		else:
			slot.update(null)


func resume():
	get_tree().paused = false
	$Character2.stop()
	$Coins/Coin.stop()
	InputMap.load_from_project_settings()
	hide()
 
func pause():
	InputMap.action_erase_events("esc")
	%Dmg_val.text = str(PlayerStats.damage)
	%Ats_val.text = str(PlayerStats.attack_speed)
	%Hp_val.text = str(int(PlayerStats.health)) + "/" + str(PlayerStats.max_hp)
	%Def_val.text = str(PlayerStats.defence)
	$Coins/coin_amount.text = str(PlayerStats.coins)
	update_slots()
	$Character2.play("character")
	$Coins/Coin.play("coin")
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

func on_slot_pressed(slot):
	pass
