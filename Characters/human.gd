extends Node2D

var speed = 75
var player_ref=null

#Starting weapon
var sword = preload("res://Attacks/Sword.tscn")
@onready var  SwordTimer=get_node("SwordTimer")#Reloading timer
var SwordSpeed=1.0 #How slow weapon is, the higher the number the slower the weapon
var SwordReloadSpeed=(SwordSpeed * ((100-PlayerStats.reload_reduction)/100))#Time to reload

@onready var player = get_tree().get_first_node_in_group("player")
#To add
func attack():
	SwordTimer.wait_time=SwordReloadSpeed
	if SwordTimer.is_stopped():
		SwordTimer.start()

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


func _on_sword_timer_timeout() -> void:
	pass # Replace with function body.
