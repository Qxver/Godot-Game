extends Area2D

#Weapon stats
var level = 1
var pierce = 1 
var speed = 100
var damage = 60
var attacksize = 1.0

#Aiming stats
var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

#setting rotation to enemy
func _ready() -> void:
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(180)	

#moving projectiles
func _physics_process(delta) -> void:
		global_position += angle * speed * delta

#Deleting projectiles after hitting enough enemies
func enemy_hit() -> void:
	pierce -= 1
	if pierce <= 0:
		queue_free()

func DealDamage():
	enemy_hit()
	return damage

#Deleting projectiles after some time
func _on_duration_timeout() -> void: 
	queue_free()
