extends Node
var damage = 30
var max_hp = 100
var health = 100
var attack_speed = 100
var defence: int = 0
var damage_reduction: float = 1 - (defence / 100)
var reload_reduction=1.0 #in percentages

var inventory: Array[InvItems]
var coins = 0

func item_effect(item: InvItems,operation: int):
	if item.item_type>0 and item.item_type<5:
		if operation == 1:
			defence -= item.deffence
			print(defence)
		elif operation == 2:
			defence += item.deffence
			print(defence)
