extends CharacterBody2D

var player
var damage = 5.0  # mob damage

func _ready() -> void:
	player = get_node("/root/Game/Player")
	$AnimatedSprite2D.play("walk")
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * 40  # mob speed
		
		$AnimatedSprite2D.flip_h = direction.x < 0  # flip sprite
		
		move_and_slide()
