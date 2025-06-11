extends Area2D
#Weapon stats
var level = 1
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
	$Explosion.disabled=true

#moving projectiles
func _physics_process(delta) -> void:
	if can_move:
		global_position += target * PlayerStats.attack_speed*0.75 * delta
		animation_bomb()

#Deleting projectiles after hitting enough enemies
func enemy_hit() -> void:
	explosion()

func stun():
	return duration

func DealDamage():
	enemy_hit()
	return PlayerStats.damage*damage_multiplier
	
func explosion() -> void:
	var audio = preload("res://Assets/Sound/Effects/Retro_Impact_20.wav")  
	SoundManager.play_audio(audio)
	can_move=false
	$Explosion.disabled=false
	damage_multiplier = 2.0
	$BombExplsionTime.start()
	animation_explosion()
	
func _on_timer_timeout() -> void:
	explosion()

func _on_bomb_explsion_time_timeout() -> void:
	queue_free()
	
func animation_bomb():
	$AnimatedSprite2D.scale=Vector2(0.1, 0.1)
	$AnimatedSprite2D.play('bomb')

func animation_explosion():
	$AnimatedSprite2D.scale=Vector2(0.9, 0.9)
	$AnimatedSprite2D.play('explosion')
