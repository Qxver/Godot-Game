extends CharacterBody2D

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
		
	var overlapping_mobs = %HealthBox.get_overlapping_bodies()
	for mob in overlapping_mobs:
		if mob.is_in_group("enemies"):
			health -= mob.damage
			%ProgressBar.value = health
			if health <= 0.0:
				health_depleted.emit()
