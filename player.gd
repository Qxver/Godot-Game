extends CharacterBody2D

#Bow starting weapon
var bow = preload("res://Attacks/bow.tscn")
@onready var  BowTimer=get_node("Attack/BowTimer")#Reloading time
@onready var BowAttackTimer=get_node("Attack/BowTimer/BowAttackTimer") #AttackTime
var BowAttackSpeed=1.5
var BowAmmo=0
var BowBaseAmmo=1
#Enemy related
var enemy_close=[]

func _ready():
	attack()

func attack():
	BowTimer.wait_time=BowAttackSpeed
	if BowTimer.is_stopped():
		BowTimer.start()
		
func getRandomTarget():
	if enemy_close.size()>0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP
	

func _on_bow_timer_timeout():
	BowAmmo=BowBaseAmmo
	BowAttackTimer.start()
	
func _on_bow_attack_timer_timeout():
	if BowAmmo>0:
		var BowAttack= bow.instantiate()
		BowAttack.global_position = global_position
		BowAttack.target=Vector2.UP
		add_child(BowAttack)
		BowAmmo-=1
		if BowAmmo > 0:
			BowAttackTimer.start()
		else :
			BowAttackTimer.stop()

signal health_depleted
var health = 100.0  # player health

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")  # player movement
	velocity = direction * 100  # player speed
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
		
		
func _process(delta):		
	var overlapping_mobs = %HealthBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob.is_in_group("enemies"):
				health 	-= mob.damage * delta
		print("Health:", health)
		%ProgressBar.value = health
		if health <= 0:
			health_depleted.emit()


func _on_enemy_detection_body_entered(body: Node2D):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_body_exited(body: Node2D):
	if enemy_close.has(body):
		enemy_close.erase(body)
