extends Node2D

var speed = 75
var player_ref=null

#Starting weapon
var sword = preload("res://Attacks/Sword.tscn")
@onready var  SwordTimer=get_node("SwordTimer")#Reloading timer
@onready var SwordAttackTimer=get_node("SwordTimer/SwordAttackTimer") #Attack timer
var SwordSpeed=1 #How slow weapon is, the higher the number the slower the weapon
var SwordReloadSpeed=(SwordSpeed * ((100-PlayerStats.reload_reduction)/100))#Time to reload
var SwordAmmo=0
var SwordBaseAmmo=10

@onready var player = get_tree().get_first_node_in_group("player")

func attack():
	SwordTimer.wait_time=SwordReloadSpeed
	if SwordTimer.is_stopped():
		SwordTimer.start()

func _on_sword_timer_timeout():
	SwordAmmo=SwordBaseAmmo
	SwordAttackTimer.wait_time=(SwordSpeed*(100-PlayerStats.reload_reduction))/(PlayerStats.attack_speed)
	SwordAttackTimer.start()
	SwordTimer.wait_time=SwordSpeed * PlayerStats.reload_reduction
	
func _on_sword_attack_timer_timeout():
	if SwordAmmo>0:
		var SwordAttack= sword.instantiate()
		SwordAttack.global_position = global_position
		SwordAttack.target=player_ref.GetClosestTarget()
		add_child(SwordAttack)
		SwordAttack.global_position = player_ref.global_position
		SwordAmmo-=1
		if SwordAmmo > 0:
			SwordAttackTimer.start()
		else :
			SwordAttackTimer.stop()
	
func animation():
	var is_moving= Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")
	if is_moving:
		$AnimatedSprite2D.play("walk")
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
func animation_hurt():
	$AnimatedSprite2D.play('hurt')
	
func animation_death():
	$AnimatedSprite2D.play('death')
	await $AnimatedSprite2D.animation_finished
	return 
