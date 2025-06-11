extends Area2D
#Weapon stats
var level = 1
var damage_multiplier = 1.25

#Aiming stats
var target = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

#setting rotation to enemy
func _ready() -> void:
	add_to_group("Attacks")
	rotation = target.angle()

#moving projectiles
func _physics_process(delta) -> void:
	global_position += target * PlayerStats.attack_speed * delta

func DealDamage():
	return PlayerStats.damage*damage_multiplier

#Deleting projectiles after some time
func _on_duration_timeout() -> void: 
	queue_free()
