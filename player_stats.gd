extends Node
var damage = 30
var max_hp = 100
var health = 100
var attack_speed = 100
var defence: float = 0
var damage_reduction: float = 1 - (defence / 100)

var inventory: Array[InvItems]
