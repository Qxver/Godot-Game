extends CharacterBody2D
#Player related
var speed = 100
var is_dead = false
signal health_depleted
signal levelup

#Level/Exp related
var level=1
var exp: float = 0.0
var exp_to_next_level: float = 1000

#Enemy related
var enemy_close: Array=[] #Array of all enemies in detection zone

#Character related
var character_manager=preload('res://Characters/Character_manager.tscn')
var manager = null

func _ready():
	set_manager()
	await get_tree().create_timer(1.0).timeout
	attack()

func attack():
	if manager:
		manager.attack()
	else:
		print("Zly manager")

func set_manager():
	if manager:
		remove_child(manager)
		manager.queue_free()
	manager=character_manager.instantiate()
	manager.player_ref=self
	add_child(manager)

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
	animation()

	# animation
func animation():
	manager.animation()
func animation_hurt():
	manager.animation_hurt()
func animation_death():
	await manager.animation_death()

	

func _process(delta) -> void:		
	var overlapping_mobs = %HealthBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob and is_instance_valid(mob) and mob.is_in_group("enemies") and not is_dead:
				PlayerStats.health -= mob.damage * delta
				animation_hurt()
		%HealthBar.value = PlayerStats.health
		if PlayerStats.health <= 0 and not is_dead:
			is_dead = true
			await animation_death()
			health_depleted.emit()
			
func _on_level_up_as_up() -> void:
	PlayerStats.base_ats += 15
	PlayerStats.update_stats()
	attack()
	
