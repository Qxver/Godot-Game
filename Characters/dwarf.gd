extends Node2D

var speed=60
var player=preload("res://player.tscn")

#Starting weapon
var bomb = preload("res://Attacks/bomb.tscn")
@onready var BombTimer=get_node("Attack/BombTimer")#Reloading time
@onready var BombAttackTimer=get_node("Attack/BombTimer/BombAttackTimer") #Attack timer
var BombSpeed=3.0 #How slow weapon is, the higher the number the slower the weapon
var BombReloadSpeed=BombSpeed * PlayerStats.reload_reduction#Time to reload
var BombAmmo = 0
var BombBaseAmmo=1

func attack():
	BombTimer.wait_time=BombReloadSpeed
	if BombTimer.is_stopped():
		BombTimer.start()
	
func _on_bomb_timer_timeout() -> void:
	BombAmmo=BombBaseAmmo
	BombAttackTimer.wait_time=BombSpeed/((PlayerStats.attack_speed*0.01)*1)
	BombAttackTimer.start() 
	BombTimer.wait_time=BombSpeed * PlayerStats.reload_reduction
	
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
	print("Hurt")
	$AnimatedSprite2D.play('hurt')
	
func animation_death():
	print("Smierc")
	$AnimatedSprite2D.play('death')
	await $AnimatedSprite2D.animation_finished
	return 
