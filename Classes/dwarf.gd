extends Node2D

var speed=60

@onready var player = get_tree().get_first_node_in_group("player")
var bomb = preload("res://Attacks/bomb.tscn")
@onready var BombTimer=get_node("Attack/BombTimer")#Reloading time
@onready var BombAttackTimer=get_node("Attack/BombTimer/BombAttackTimer") #AttackTime
var BombAttackSpeed=1
var BombAmmo = 0
var BombBaseAmmo=1

func attack():
	BombTimer.wait_time=BombAttackSpeed
	if BombTimer.is_stopped():
		BombTimer.start()
	
func _on_bomb_timer_timeout() -> void:
	BombAmmo=BombBaseAmmo
	BombAttackTimer.start() 
	
func _on_bomb_attack_timer_timeout() -> void:
	if BombAmmo >0:
		var BombAttack= bomb.instantiate()
		get_tree().current_scene.add_child(BombAttack)
		BombAttack.global_position = global_position
		BombAttack.target=player.GetClosestTarget()
		BombAmmo-=1
		if BombAmmo > 0:
			BombAttackTimer.start()
		else :
			BombAttackTimer.stop()
