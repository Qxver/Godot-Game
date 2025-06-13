extends Node2D

@onready var player = get_node("Player")

var coins: int = 0
const save_path = "res://save_data.json" # save game path
var item_scene = preload("res://Item.tscn")
var decorations = [
	preload("res://Assets/Terrain/bushes/Bush_blue_flowers2.png"),
	preload("res://Assets/Terrain/bushes/Bush_orange_flowers2.png"),
	preload("res://Assets/Terrain/bushes/Bush_pink_flowers2.png"),
	preload("res://Assets/Terrain/bushes/Bush_red_flowers2.png"),
	preload("res://Assets/Terrain/bushes/Bush_simple1_2.png"),
	preload("res://Assets/Terrain/bushes/Bush_simple2_3.png"),
	preload("res://Assets/Terrain/bushes/Fern1_2.png"),
	preload("res://Assets/Terrain/bushes/Fern2_2.png"),
	preload("res://Assets/Terrain/trees/Broken_tree1.png"),
	preload("res://Assets/Terrain/trees/Broken_tree2.png"),
	preload("res://Assets/Terrain/trees/Flower_tree1.png"),
	preload("res://Assets/Terrain/trees/Flower_tree2.png"),
	preload("res://Assets/Terrain/trees/Fruit_tree1.png"),
	preload("res://Assets/Terrain/trees/Moss_tree1.png"),
	preload("res://Assets/Terrain/trees/Moss_tree3.png"),
	preload("res://Assets/Terrain/trees/Tree3.png")
]
var decoration_distance = 500
var decoration_spawn_radius = 600
var placed_positions = []

# spawn enemy randomly on path2D set outside of player's vision
func spawn_orc() -> void:
	var orc = preload("res://Enemies/orc.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	orc.global_position = %PathFollow2D.global_position
	add_child(orc)
	
func spawn_elite() -> void:
	var elite = preload("res://Enemies/orc_elite.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	elite.global_position = %PathFollow2D.global_position
	add_child(elite)

# spawn enemy timer
func _on_timer_mob_spawn_timeout() -> void:
	spawn_orc()
	
func _on_timer_elite_spawn_timeout() -> void:
	spawn_elite()

# screen timer
var elapsed_time: int= 0  # time (seconds)
func _on_timer_timeout2() -> void:
	elapsed_time += 1
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	%TimeLabel.set_text(str(minutes, ":", seconds if seconds >= 10 else "0" + str(seconds)))

# change mob spawn time -0.1s every 10s elapsed time
var time_passed = 0
func _physics_process(delta: float) -> void:
	time_passed += delta
	if %TimerMobSpawn.wait_time > 0.1:
		if time_passed >= 5:
			time_passed = 0
			%TimerMobSpawn.wait_time -= 0.1
			
	# health and exp bar
	%HealthBar.value = PlayerStats.health
	%HealthBar.max_value = PlayerStats.max_hp
	var player = get_node("Player")
	%ExpBar.max_value = player.exp_to_next_level
	%ExpBar.value = player.exp
	%ExpLabel.text = "Level " + str(player.level)
	%HealthLabel.text = str(int(PlayerStats.health)) + "/" + str(int(PlayerStats.max_hp))
			
			
func _ready() -> void:
	load_game() # load game stats on start
	print(SoundManager.Soundtrack2Progress)
	SoundManager.play_soundtrack2() # soundtrack
	
	randomize()
	%TimeLabel.set_text("0:00")
	%ExpLabel.text = "Level 1"
	%HealthLabel.text = str(int(PlayerStats.health)) + "/" + str(int(PlayerStats.max_hp))
	
	var item = item_scene.instantiate()
	coin_label() 
	
func _process(delta):
	if decorations.is_empty():
		return
	spawn_decorations_near_player()
	
func coin_label():
	%CoinLabel.text = str(coins)
	
#Game over screen
func _on_player_health_depleted() -> void:
	$Menus/GameOver.pause()

#Level up screen
func _on_player_levelup() -> void:
	$Menus/LevelUP.pause()

# update coin value
func _on_coin_collected() -> void:
	PlayerStats.coins += 1
	coins += 1
	coin_label()
	save_game(coins)

#generating trees and bushes around the player
func spawn_decorations_near_player():
	for i in range(3):
		var random_offset = Vector2(randf_range(-decoration_spawn_radius, decoration_spawn_radius), randf_range(-decoration_spawn_radius, decoration_spawn_radius))
		var spawn_position = player.global_position + random_offset
		var too_close = false
		for pos in placed_positions:
			if pos.distance_to(spawn_position) < 150:
				too_close = true
				break
		if spawn_position.distance_to(player.global_position) < 150:
			too_close = true
		if not too_close:
			var decoration_texture = decorations[randi() % decorations.size()]
			var decoration = StaticBody2D.new()
			var sprite = Sprite2D.new()
			sprite.texture = decoration_texture
			sprite.global_position = spawn_position
			decoration.scale = Vector2(0.6,0.6)
			decoration.add_child(sprite)
			decoration.z_index = -1
			add_child(decoration)
			placed_positions.append(spawn_position)

# auto save to file
func save_game(coins: int) -> void:
	PlayerStats.inventory+=PlayerStats.equiped_items
	PlayerStats.equiped_items.clear()
	var items = []
	for item in PlayerStats.inventory:
		items.append(item.resource_path)
	var save_data = {
		"coins": coins,
		"items": items
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify((save_data)))
	file.close()
	
func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var data = file.get_as_text()
		file.close()
		var parsed_json = JSON.parse_string(data)
		var loaded_inv_paths = []
		if typeof(parsed_json) == TYPE_DICTIONARY:
			coins = parsed_json.get("coins", 0)
			loaded_inv_paths = parsed_json.get("items", [])
			PlayerStats.inventory.clear()
			for item_path in loaded_inv_paths:
				if typeof(item_path) == TYPE_STRING and item_path.begins_with("res://"):
					var loaded_item_resource = load(item_path)
					if loaded_item_resource is InvItems:
						PlayerStats.inventory.append(loaded_item_resource)
