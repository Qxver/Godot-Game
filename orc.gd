extends CharacterBody2D

var player

func _ready() -> void:
	player = get_node("/root/Game/Player")
	$AnimatedSprite2D.play("walk")
		

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 40  # mob speed
	
	if player:
		var direction2 = (player.global_position.x - global_position.x)
		
		if abs(direction2) > 5:
			velocity.x = sign(direction2) * 40
			$AnimatedSprite2D.flip_h = direction2 < 0
			move_and_slide()
