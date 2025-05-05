extends CharacterBody2D
@export var hit_flash_color: Color = Color(3,3,3)
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game = get_node("/root/Game")
@onready var player = get_node("/root/Game/Player")
var original_color: Color 

var item_scene = preload("res://Item.tscn")
var damage = 60.0  # mob damage
var health = 200.0  # mob health
var alive : bool = true
var exp = 3000 #mob exp drop

func _ready() -> void:
	player = get_node("/root/Game/Player")
	$AnimatedSprite2D.play("walk")
	add_to_group("enemies")  # enemies group
	original_color = $AnimatedSprite2D.modulate

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * 40  # mob speed
		
		$AnimatedSprite2D.flip_h = direction.x < 0  # flip sprite
		
		move_and_slide()


func _on_hurt_box_area_entered(area: Area2D):
	if area.is_in_group("Attacks"):
		var weapondamage = area.DealDamage()
		hurt(weapondamage)

func hurt(weapondamage):
	health -= weapondamage
	flash_white()
	if health <= 0:
		queue_free()
		die()
	
func die():
	alive = false
	drop_item()
	player.get_exp(exp)
	
func flash_white():
	$AnimatedSprite2D.modulate = hit_flash_color 
	var timer = get_tree().create_timer(0.1)
	timer.timeout.connect(_restore_color)	
	
func _restore_color():
	$AnimatedSprite2D.modulate = original_color  
	
# item drops
# coin - 10%, heal - 41%, armour1 - 30%, armour2 - 9%, armour3 - 7%, armour4 - 3%
func drop_item():
	var item = item_scene.instantiate()
	item.position = position
	var roll_item = randi_range(0, 100)
	if roll_item in range(0, 9):
		item.item_type = 0
	elif roll_item in range(10, 50):
		item.item_type = 1
	elif roll_item in range(51, 81):
		item.armour_type = randi_range(0, 3)
		item.item_type = 2
	elif roll_item in range(82, 90):
		item.armour_type = randi_range(0, 3)
		item.item_type = 3
	elif roll_item in range(91, 97):
		item.armour_type = randi_range(0, 3)
		item.item_type = 4
	else:
		item.armour_type = randi_range(0, 3)
		item.item_type = 5
		
	if item.item_type == 0:
		item.collected.connect(game._on_coin_collected)
	game.call_deferred("add_child", item)
	item.add_to_group("items")	
