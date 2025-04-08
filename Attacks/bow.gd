extends Area2D
#Weapon stats
var level = 1
var pierce = 1 
var speed = 100
var damage_multiplier = 1
var attacksize = 1.0

#Aiming stats
var target = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

#setting rotation to enemy
func _ready() -> void:
	add_to_group("Attacks")
	rotation = target.angle() + deg_to_rad(180)	

#moving projectiles
func _physics_process(delta) -> void:
	global_position += target * speed * delta

#Deleting projectiles after hitting enough enemies
func enemy_hit() -> void:
	pierce -= 1
	if pierce <= 0:
		queue_free()

func DealDamage():
	enemy_hit()
	return PlayerStats.damage*damage_multiplier

#Deleting projectiles after some time
func _on_duration_timeout() -> void: 
	queue_free()
