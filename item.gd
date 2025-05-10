extends Area2D

signal collected
var item
var item_type: int
var armour_type: int
var jewelry_type: int

# preloading items
var coin = preload("res://Assets/Items/coin_spin-Sheet.png")
var health_box = preload("res://Assets/Items/health_drop.png")
var helmet1 = preload("res://Assets/Items/Armour/helmet1.tres")
var helmet2 = preload("res://Assets/Items/Armour/helmet2.tres")
var helmet3 = preload("res://Assets/Items/Armour/helmet3.tres")
var helmet4 = preload("res://Assets/Items/Armour/helmet4.tres")
var chestplate1 = preload("res://Assets/Items/Armour/chestplate1.tres")
var chestplate2 = preload("res://Assets/Items/Armour/chestplate2.tres")
var chestplate3 = preload("res://Assets/Items/Armour/chestplate3.tres")
var chestplate4 = preload("res://Assets/Items/Armour/chestplate4.tres")
var leggings1 = preload("res://Assets/Items/Armour/leggings1.tres")
var leggings2 = preload("res://Assets/Items/Armour/leggings2.tres")
var leggings3 = preload("res://Assets/Items/Armour/leggings3.tres")
var leggings4 = preload("res://Assets/Items/Armour/leggings4.tres")
var boots1 = preload("res://Assets/Items/Armour/boots1.tres")
var boots2 = preload("res://Assets/Items/Armour/boots2.tres")
var boots3 = preload("res://Assets/Items/Armour/boots3.tres")
var boots4 = preload("res://Assets/Items/Armour/boots4.tres")
var ruby_ring = preload("res://Assets/Items/Jewelry/ruby_ring.tres")
var ruby_necklace = preload("res://Assets/Items/Jewelry/ruby_necklace.tres")
var emerald_ring = preload("res://Assets/Items/Jewelry/emerald_ring.tres")
var emerald_necklace = preload("res://Assets/Items/Jewelry/emerald_necklace.tres")
var sapphire_ring = preload("res://Assets/Items/Jewelry/sapphire_ring.tres")
var sapphire_necklace = preload("res://Assets/Items/Jewelry/sapphire_necklace.tres")
var amethyst_ring = preload("res://Assets/Items/Jewelry/amethyst_ring.tres")
var amethyst_necklace = preload("res://Assets/Items/Jewelry/amethyst_necklace.tres")

# armor item pools
var armour1 = [helmet1, chestplate1, leggings1, boots1]
var armour2 = [helmet2, chestplate2, leggings2, boots2]
var armour3 = [helmet3, chestplate3, leggings3, boots3]
var armour4 = [helmet4, chestplate4, leggings4, boots4]

# jewelry item pool
var jewelry = [ruby_ring, ruby_necklace, sapphire_ring, sapphire_necklace, amethyst_ring, amethyst_necklace, emerald_ring, emerald_necklace]

var item_pool = [coin, health_box, armour1, armour2, armour3, armour4, jewelry] # item pool

func _ready() -> void:
	item = item_pool[item_type]
	if item is not Array:
		$Sprite2D.texture = item
		if item_type == 1:
			$Sprite2D.scale = Vector2(0.6, 0.6)
			$Sprite2D.region_enabled = true
			$Sprite2D.region_rect = Rect2(0, 0, 8, 8)
	else:
		$Sprite2D.region_enabled = false
		if item_type == 6:
			$Sprite2D.scale = Vector2(0.6, 0.6)
			$Sprite2D.texture = item_pool[item_type][jewelry_type]
		else:
			$Sprite2D.scale = Vector2(0.75, 0.75)
			$Sprite2D.texture = item_pool[item_type][armour_type]
		
# item collection and item action on pickup
func _on_body_entered(body: Node2D) -> void:
	collected.emit()
	if item_type == 1:
		PlayerStats.health += 20
		if PlayerStats.health >= PlayerStats.max_hp:
			PlayerStats.health = PlayerStats.max_hp
	queue_free()
