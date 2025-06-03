extends Area2D
#Weapon stats
var level = 1
var pierce = 1 
var damage_multiplier = 1.0
var attacksize = 1.0

#Aiming stats
var target = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

#setting rotation to enemy
func _ready() -> void:
	SoundManager.sound_effect.volume_db = -15
	var audio = preload("res://Assets/Sound/Effects/arrow-swish_03-306040.mp3")  
	SoundManager.play_audio(audio)
	add_to_group("Attacks")
	rotation = target.angle() + deg_to_rad(180)	

#moving projectiles
func _physics_process(delta) -> void:
	global_position += target * PlayerStats.attack_speed * delta

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
