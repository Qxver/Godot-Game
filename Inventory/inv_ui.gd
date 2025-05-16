extends Control

@onready var slots : Array =  $NinePatchRect/Inv/InvContainer.get_children()

func _ready():
	PlayerStats.inventory=[preload("res://Inventory/Items/Armour/chestplate3.tres"),preload("res://Inventory/Items/Armour/chestplate1.tres"),preload("res://Inventory/Items/Armour/chestplate3.tres")]
	hide()

func update_slots():
	$Character2.play("character")
	$Coins/Coin.play("coin")
	update_stats()
	$Coins/coin_amount.text = str(PlayerStats.coins)
	var inv = PlayerStats.inventory
	var inv_size = inv.size()
	var slot_count = slots.size()

	for i in range(slot_count):
		if not slots[i].is_connected("equip", Callable(self, "_on_slot_equip")):
			slots[i].connect("equip", Callable(self, "_on_slot_equip"))
		if i < inv_size:
			slots[i].update(inv[inv_size - 1 - i])
		else:
			slots[i].update(null)

func resume():
	$Coins/Coin.stop()
	$Character2.stop()
	get_tree().paused = false
	InputMap.load_from_project_settings()
	hide()
 
func pause():
	PlayerStats.inventory+=[preload("res://Inventory/Items/Armour/boots1.tres"),preload("res://Inventory/Items/Armour/boots3.tres"),preload("res://Inventory/Items/Armour/chestplate3.tres")]
	InputMap.action_erase_events("esc")
	update_slots()
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
	
func _on_slot_equip(item: InvItems):
	for i in range(PlayerStats.inventory.size()):
		if PlayerStats.inventory[i].resource_path == item.resource_path:
			var eq_item = PlayerStats.inventory.pop_at(i)
			equip(eq_item,i)
			break
	
func equip(item: InvItems,index):
	var slot: Slot
	match item.item_type:
		1:
			slot = $NinePatchRect/Equipment/Armour/GridContainer/Helmet
			handle_slot_swap(slot, index, item)
		2:
			slot = $NinePatchRect/Equipment/Armour/GridContainer/Chestplate
			handle_slot_swap(slot, index, item)
		3:
			slot = $NinePatchRect/Equipment/Armour/GridContainer/Leggings
			handle_slot_swap(slot, index, item)
		4:
			slot = $NinePatchRect/Equipment/Armour/GridContainer/Boots
			handle_slot_swap(slot, index, item)

func handle_slot_swap(slot, index, item):
	if slot.itemInSlot != null:
		var swapped_item = replace_item(index, item, slot.itemInSlot)
		slot.update(item)
		PlayerStats.item_effect(swapped_item,1)
		PlayerStats.item_effect(item,2)
		update_stats()
	else:
		slot.update(item)
		PlayerStats.item_effect(item,2)
		update_stats()

func replace_item(index, old_item, new_item):
	PlayerStats.inventory.push_back(new_item)
	update_slots()
	return new_item

func update_stats():
	%Dmg_val.text = str(PlayerStats.damage)
	%Ats_val.text = str(PlayerStats.attack_speed)
	%Hp_val.text = str(int(PlayerStats.health)) + "/" + str(PlayerStats.max_hp)
	%Def_val.text = str(PlayerStats.defence)
