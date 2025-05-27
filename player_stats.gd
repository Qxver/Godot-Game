extends Node

var damage: int
var max_hp: int
var health: int
var attack_speed= 100
var defence: float = 0
var damage_reduction: float = 1
var reload_reduction = 0.0 #in percentages 0-0% 90-90%
var character_id: int = 0

var inventory: Array[InvItems]
var coins = 0

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
		elif operation == 2:
			defence += item.defence
			damage_reduction= 1 - (defence / 100)
	else:
		if operation == 1:
			dmg_multiplayer -= item.attack
			hp_multiplayer -= item.hp
			ats_multiplayer -= item.ats
			xp_multiplayer -= item.xp
		elif operation == 2:
			dmg_multiplayer += item.attack
			hp_multiplayer += item.hp
			ats_multiplayer += item.ats
			xp_multiplayer += item.xp
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
