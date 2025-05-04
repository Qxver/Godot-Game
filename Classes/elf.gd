extends Node2D

var speed = 100

@onready var player = get_tree().get_first_node_in_group("player")
var bow = preload("res://Attacks/bow.tscn")
@onready var  BowTimer=get_node("Attack/BowTimer")#Reloading time
@onready var BowAttackTimer=get_node("Attack/BowTimer/BowAttackTimer") #AttackTime
var BowAttackSpeed=1
var BowAmmo=0
var BowBaseAmmo=3

func attack():
	BowTimer.wait_time=BowAttackSpeed
	if BowTimer.is_stopped():
		BowTimer.start()

func _on_bow_timer_timeout():
	BowAmmo=BowBaseAmmo
	BowAttackTimer.start()

func _on_bow_attack_timer_timeout():
	if BowAmmo>0:
		var BowAttack= bow.instantiate()
		BowAttack.global_position = global_position
		BowAttack.target=player.GetClosestTarget()
		add_child(BowAttack)
		BowAmmo-=1
		if BowAmmo > 0:
			BowAttackTimer.start()
		else :
			BowAttackTimer.stop()
			
