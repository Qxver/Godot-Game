extends Area2D
#Weapon stats
var level = 1
var pierce = 1 
var damage_multiplier = 0.75

@onready var player = get_tree().get_first_node_in_group("player")

#setting rotation to enemy
func _ready() -> void:
	add_to_group("Attacks")

func DealDamage():
	return PlayerStats.damage*damage_multiplier


func _on_timer_timeout() -> void:
	pass # Replace with function body.
