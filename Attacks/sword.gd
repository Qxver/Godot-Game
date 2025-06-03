extends Area2D
#Weapon stats
var level = 1
var damage_multiplier = 1.25
var attack_direction=Vector2.LEFT

@onready var player = get_tree().get_first_node_in_group("player")

#setting rotation to enemy
func _ready() -> void:
	add_to_group("Attacks")

func _process(delta: float) -> void:
	if player:
		pass
		
func _update_sword_oretation():
	var look_direction= Input.get_vector("move_left", "move_right", "move_up", "move_down")

func DealDamage():
	return PlayerStats.damage*damage_multiplier


func _on_timer_timeout() -> void:
	queue_free()
