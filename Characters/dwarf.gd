extends Node2D

var speed=60
var player_ref=null

#Starting weapon
var bomb = preload("res://Attacks/bomb.tscn")
@onready var BombTimer=get_node("BombTimer")#Reloading time
@onready var BombAttackTimer=get_node("BombTimer/BombAttackTimer") #Attack timer
var BombSpeed=3.0 #How slow weapon is, the higher the number the slower the weapon
var BombReloadSpeed=(BombSpeed * ((100-PlayerStats.reload_reduction)/100))#Time to reload
var BombAmmo = 0
var BombBaseAmmo=1

func attack():
	print("atak")
	BombTimer.wait_time=BombReloadSpeed
	print(BombReloadSpeed)
	if BombTimer.is_stopped():
		BombTimer.start()
	

func _on_bomb_timer_timeout() -> void:
	print("bomb timeout")
	BombAmmo=BombBaseAmmo
	BombAttackTimer.wait_time=1
	BombAttackTimer.start()
	if not BombAttackTimer.is_stopped():
		print("bobmatak timoit start")
	BombTimer.wait_time=BombSpeed * PlayerStats.reload_reduction
	
func _on_bomb_attack_timer_timeout() -> void:
	print("bomba atak timeout")
	print(BombAttackTimer.wait_time)
	if BombAmmo >0:
		var BombAttack= bomb.instantiate()
		BombAttack.target=player_ref.GetClosestTarget()
		add_child(BombAttack)
		print("BOMBA")
		BombAttack.global_position = player_ref.global_position
		BombAmmo-=1
		if BombAmmo > 0:
			BombAttackTimer.start()
		else :
			BombAttackTimer.stop()


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
