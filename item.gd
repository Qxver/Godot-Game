extends Area2D

signal collected
var item_type: int

var coin = preload("res://Assets/Items/coin_spin-Sheet.png")
var health_box = preload("res://Assets/Items/health_drop.png")
var textures = [coin, health_box]

func _ready() -> void:
	$Sprite2D.texture = textures[item_type]

# item collection
func _on_body_entered(body: Node2D) -> void:
	collected.emit()
	if item_type == 1:
		PlayerStats.health += 20
		if PlayerStats.health >= PlayerStats.max_hp:
			PlayerStats.health = PlayerStats.max_hp
	queue_free()
