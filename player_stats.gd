extends Node
var damage = 30
var max_hp = 100
var health = 100
var attack_speed = 100
var defence: float = 0
var damage_reduction: float = 1
var reload_reduction: float = 1.0 #in percentages
var character_id: int = 0

var inventory: Array[InvItems]
var coins = 0
var xp_multiplayer = 1

func item_effect(item: InvItems,operation: int):
	if item.item_type>0 and item.item_type<5:
		if operation == 1:
			defence -= item.deffence
			damage_reduction= 1 - (defence / 100)
			print(damage_reduction)
		elif operation == 2:
			defence += item.deffence
			damage_reduction= 1 - (defence / 100)
			print(damage_reduction)
