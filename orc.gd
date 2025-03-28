extends CharacterBody2D

var player
var damage = 30.0  # mob damage
var health = 30.0  # mob health

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


func _on_hurt_box_area_entered(area: Area2D):
	if area.is_in_group("Attacks"):
		var weapondamage=area.DealDamage()
		hurt(weapondamage)

func hurt(weapondamage):
	health-=weapondamage
	if health<=0:
		queue_free()
	
