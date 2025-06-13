extends Node

const save_path = "res://save_data.json" # save game path

var damage: int
var max_hp: int
var health: int
var attack_speed= 100
var defence: float = 0
var damage_reduction: float = 1
var reload_reduction = 0.0 #in percentages 0-0% 90-90%
var character_id: int = 0

var inventory: Array[InvItems]
var equiped_items: Array[InvItems]
var coins: int = 0

var xp_multiplayer: int
var dmg_multiplayer: float
var hp_multiplayer: float
var ats_multiplayer: float

var base_hp = 0
var base_dmg = 0
var base_ats = 100

func item_effect(item: InvItems,operation: int):
	if item.item_type<=4:
		if operation == 1:
			defence -= item.defence
			damage_reduction= 1 - (defence / 100)
			equiped_items.erase(item)
		elif operation == 2:
			defence += item.defence
			damage_reduction= 1 - (defence / 100)
			equiped_items.append(item)
	else:
		if operation == 1:
			dmg_multiplayer -= item.attack
			hp_multiplayer -= item.hp
			ats_multiplayer -= item.ats
			xp_multiplayer -= item.xp
			equiped_items.erase(item)
		elif operation == 2:
			dmg_multiplayer += item.attack
			hp_multiplayer += item.hp
			ats_multiplayer += item.ats
			xp_multiplayer += item.xp
			equiped_items.append(item)
			update_stats()
			

func update_stats():
	damage= base_dmg * dmg_multiplayer if dmg_multiplayer != 0.0 else base_dmg
	max_hp= base_hp * hp_multiplayer if hp_multiplayer != 0.0 else base_hp
	attack_speed = base_ats * ats_multiplayer if ats_multiplayer != 0.0 else base_ats
	#xp_multiplayer =  
	
func player_base_stats(x: int):
	match x:
		1:
			damage = 30
			base_dmg = 30
			health = 100
			max_hp = 100
			base_hp = 100
		2:
			damage = 40
			base_dmg = 40
			health = 150
			max_hp = 150
			base_hp = 150
		3:
			damage = 50
			base_dmg = 50
			health = 125
			max_hp = 125
			base_hp = 125
			
func save_game(coins: int) -> void:
	inventory+=equiped_items
	equiped_items.clear()
	var items = []
	for item in inventory:
		items.append(item.resource_path)
	var save_data = {
		"coins": coins,
		"items": items
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify((save_data)))
	file.close()
	
func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var data = file.get_as_text()
		file.close()
		var parsed_json = JSON.parse_string(data)
		var loaded_inv_paths = []
		if typeof(parsed_json) == TYPE_DICTIONARY:
			coins = parsed_json.get("coins", 0)
			loaded_inv_paths = parsed_json.get("items", [])
			inventory.clear()
			for item_path in loaded_inv_paths:
				if typeof(item_path) == TYPE_STRING and item_path.begins_with("res://"):
					var loaded_item_resource = load(item_path)
					if loaded_item_resource is InvItems:
						inventory.append(loaded_item_resource)
