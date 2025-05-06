extends Area2D
#Weapon stats
var level = 1
var speed = 100
var damage_multiplier = 0.25
var attacksize = 1.0
var duration =  1.0

var target = Vector2.ZERO
@onready var player = get_tree().get_first_node_in_group("player")
var can_move: bool = true

#setting rotation to enemy
func _ready() -> void:
	add_to_group("Attacks")
	add_to_group("Stunners")
	rotation = target.angle() + deg_to_rad(180)	
	$Explosion.disabled = true
	$Sprite2D2.visible = false

#moving projectiles
func _physics_process(delta) -> void:
	if can_move:
		global_position += target * speed * delta

#Deleting projectiles after hitting enough enemies
func enemy_hit() -> void:
	explosion()

func stun():
	return duration

func DealDamage():
	enemy_hit()
	return PlayerStats.damage*damage_multiplier
	
func explosion() -> void:
	can_move=false
	damage_multiplier = 0.75
	$Sprite2D2.visible=true
	$Explosion.call_deferred("set_disabled", true)
	$BombExplsionTime.start()
	
func _on_timer_timeout() -> void:
	explosion()

func _on_bomb_explsion_time_timeout() -> void:
	queue_free()
