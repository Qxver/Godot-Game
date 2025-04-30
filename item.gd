extends Area2D

signal collected
var item_type: int

var coin = preload("res://Assets/Items/coin_spin-Sheet.png")
var health_box = preload("res://Assets/Items/health_drop.png")
var helmet1 = preload("res://Assets/Items/Armour/helmet1.tres")
var textures = [coin, health_box, helmet1] # item pool

func _ready() -> void:
	$Sprite2D.texture = textures[item_type]
	if item_type == 2:
		$Sprite2D.region_enabled = false
	if item_type == 1:
		$Sprite2D.scale = Vector2(0.6, 0.6)
		$Sprite2D.region_enabled = true
		$Sprite2D.region_rect = Rect2(0, 0, 8, 8)
		
# item collection
func _on_body_entered(body: Node2D) -> void:
	collected.emit()
	if item_type == 1:
		PlayerStats.health += 20
		if PlayerStats.health >= PlayerStats.max_hp:
			PlayerStats.health = PlayerStats.max_hp
	queue_free()
