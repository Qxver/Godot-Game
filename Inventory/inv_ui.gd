extends Control

@onready var slots : Array =  $NinePatchRect/Inv/InvContainer.get_children()

func _ready():
	PlayerStats.inventory=[preload("res://Inventory/Items/Armour/boots2.tres"),preload("res://Inventory/Items/Armour/chestplate1.tres"),preload("res://Inventory/Items/Armour/chestplate4.tres"),preload("res://Inventory/Items/Armour/leggings1.tres"),preload("res://Inventory/Items/Armour/helmet2.tres"),preload("res://Inventory/Items/Armour/chestplate3.tres")]
	hide()

func update_slots():
	match PlayerStats.character_id:
		1:
			$Character2.scale = Vector2(5,5)
			$Character2.position = Vector2(319,134)
			$Character2.play("Elf")
		2:
			$Character2.scale = Vector2(4,4)
			$Character2.position = Vector2(313,117)
			$Character2.play("Dwarf")
		3:
			$Character2.scale = Vector2(5,5)
			$Character2.position = Vector2(319,134)
			$Character2.play("Human")
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
	hide()
 
func pause():
	PlayerStats.inventory+=[preload("res://Inventory/Items/Accessories/amethyst_belt.tres"),preload("res://Inventory/Items/Accessories/emerald_ring.tres"),preload("res://Inventory/Items/Armour/chestplate4.tres"),preload("res://Inventory/Items/Accessories/sapphire_belt.tres")]
	update_slots()
	show()
	get_tree().paused = true

func testInv():
	if Input.is_action_just_pressed("inv") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("inv") or (Input.is_action_just_pressed("esc") and self.visible) and get_tree().paused:
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
		5:
			slot = $NinePatchRect/Equipment/Accessories/Necklace
			handle_slot_swap(slot, index, item)
		6:
			slot = $NinePatchRect/Equipment/Accessories/Ring
			handle_slot_swap(slot, index, item)
		7:
			slot = $NinePatchRect/Equipment/Accessories/Bracelet
			handle_slot_swap(slot, index, item)
		8:
			slot = $NinePatchRect/Equipment/Accessories/Belt
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
		update_slots()

func replace_item(index, old_item, new_item):
	PlayerStats.inventory.push_back(new_item)
	update_slots()
	return new_item

func update_stats():
	%Dmg_val.text = str(int(PlayerStats.damage))
	%Ats_val.text = str(int(PlayerStats.attack_speed))
	%Hp_val.text = str(int(PlayerStats.health)) + "/" + str(int(PlayerStats.max_hp))
	%Def_val.text = str(int(PlayerStats.defence))
