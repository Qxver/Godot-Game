extends Node

var damage= 30
var max_hp= 100
var health= 100
var attack_speed: float = 100
var defence: float = 0
var damage_reduction: float = 1
var reload_reduction = 0.0 #in percentages 0-0% 90-90%
var character_id: int = 0

var inventory: Array[InvItems]
var coins = 0
var xp_multiplayer = 1

func item_effect(item: InvItems,operation: int):
	if item.item_type<=4:
		if operation == 1:
			defence -= item.deffence
			damage_reduction= 1 - (defence / 100)
		elif operation == 2:
			defence += item.deffence
			damage_reduction= 1 - (defence / 100)
	else:
		damage = damage * item.attack
		max_hp = max_hp * item.hp
		attack_speed = attack_speed * item.ats
		xp_multiplayer += item.xp
