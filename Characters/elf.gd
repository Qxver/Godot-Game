extends Node2D

var speed = 100
var player_ref=null

#Starting weapon
var bow = preload("res://Attacks/bow.tscn")
@onready var  BowTimer=get_node("BowTimer")#Reloading timer
@onready var BowAttackTimer=get_node("BowTimer/BowAttackTimer") #Attack timer
var BowSpeed=1.0 #How slow weapon is, the higher the number the slower the weapon
var BowReloadSpeed=BowSpeed * PlayerStats.reload_reduction#Time to reload
var BowAmmo=0
var BowBaseAmmo=3

func attack():
	BowTimer.wait_time=BowReloadSpeed
	print(BowTimer.wait_time)
	if BowTimer.is_stopped():
		BowTimer.start()

func _on_bow_timer_timeout():
	BowAmmo=BowBaseAmmo
	BowAttackTimer.wait_time=BowSpeed/((PlayerStats.attack_speed*0.01)*1)
	BowAttackTimer.start()
	BowTimer.wait_time=BowSpeed * PlayerStats.reload_reduction
	
func _on_bow_attack_timer_timeout():
	if BowAmmo>0:
		var BowAttack= bow.instantiate()
		BowAttack.global_position = global_position
		BowAttack.target=player_ref.GetClosestTarget()
		add_child(BowAttack)
		BowAmmo-=1
		if BowAmmo > 0:
			BowAttackTimer.start()
		else :
			BowAttackTimer.stop()

# animation
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
