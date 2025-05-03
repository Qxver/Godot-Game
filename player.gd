extends CharacterBody2D

#Player related
var speed = 100
var is_dead = false
signal health_depleted
signal levelup

#Starting weapon
var bow = preload("res://Attacks/bow.tscn")
@onready var  BowTimer=get_node("Attack/BowTimer")#Reloading time
@onready var BowAttackTimer=get_node("Attack/BowTimer/BowAttackTimer") #AttackTime
var BowAttackSpeed=1
var BowAmmo=0
var BowBaseAmmo=3

var bomb = preload("res://Attacks/bomb.tscn")
@onready var BombTimer=get_node("Attack/BombTimer")#Reloading time
@onready var BombAttackTimer=get_node("Attack/BombTimer/BombAttackTimer") #AttackTime
var BombAttackSpeed=1
var BombAmmo = 0
var BombBaseAmmo=1

#Level/Exp related
var level=1
var exp: float = 0.0
var exp_to_next_level: float = 1000

#Enemy related
var enemy_close: Array=[] #Array of all enemies in detection zone

func _ready():
	attack()

func attack():
	BowTimer.wait_time=BowAttackSpeed
	if BowTimer.is_stopped():
		BowTimer.start()
	BombTimer.wait_time=BombAttackSpeed
	if BombTimer.is_stopped():
		BombTimer.start()
	
func GetClosestTarget():
	if enemy_close.size()==0:
		return Vector2.UP
	var closest_enemy=null
	var min_distance=INF
	for enemy in enemy_close:
		var distance = global_position.distance_to(enemy.global_position)
		if min_distance > distance:
			min_distance=distance
			closest_enemy=enemy
	return global_position.direction_to(closest_enemy.global_position)

func _on_bow_timer_timeout():
	BowAmmo=BowBaseAmmo
	BowAttackTimer.start()
	
func _on_bow_attack_timer_timeout():
	if BowAmmo>0:
		var BowAttack= bow.instantiate()
		BowAttack.global_position = global_position
		BowAttack.target=GetClosestTarget()
		add_child(BowAttack)
		BowAmmo-=1
		if BowAmmo > 0:
			BowAttackTimer.start()
		else :
			BowAttackTimer.stop()
			
	pass # Replace with function body.
func _on_bomb_timer_timeout() -> void:
	BombAmmo=BombBaseAmmo
	BombAttackTimer.start() 
	
func _on_bomb_attack_timer_timeout() -> void:
	if BombAmmo >0:
		var BombAttack= bomb.instantiate()
		get_tree().current_scene.add_child(BombAttack)
		BombAttack.global_position = global_position
		BombAttack.target=GetClosestTarget()
		BombAmmo-=1
		if BombAmmo > 0:
			BombAttackTimer.start()
		else :
			BombAttackTimer.stop()
	
#Adding enemies to enemy_close
func _on_enemy_detection_body_entered(body: Node2D):
	if body.is_in_group("enemies"):
		if not enemy_close.has(body):
			enemy_close.append(body)

#Deleting enemies from enemy_close
func _on_enemy_detection_body_exited(body: Node2D):
	if body.is_in_group("enemies"):
		if enemy_close.has(body):
			enemy_close.erase(body)

func level_up(): 
	exp-=exp_to_next_level
	exp_to_next_level*=1.1
	level += 1
	levelup.emit()

func get_exp(enemy_exp):
	exp+=enemy_exp
	if exp>exp_to_next_level and not is_dead:
		level_up()

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")  # player movement
	velocity = direction * speed  # player speed
	move_and_slide()

	
	# animation
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.play("walk")
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		
		
func _process(delta) -> void:		
	var overlapping_mobs = %HealthBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob and is_instance_valid(mob) and mob.is_in_group("enemies") and not is_dead:
				PlayerStats.health -= mob.damage * delta
				$AnimatedSprite2D.play("hurt")
		%HealthBar.value = PlayerStats.health
		if PlayerStats.health <= 0 and not is_dead:
			is_dead = true
			$AnimatedSprite2D.play("death")
			await $AnimatedSprite2D.animation_finished
			health_depleted.emit()
			
func _on_level_up_as_up() -> void:
	BowAttackTimer.wait_time -= 0.05
