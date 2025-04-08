extends Node2D

var coins = 0
var item_scene = preload("res://Item.tscn")
@onready var health_bar = %HealthBar
@onready var player = get_node("Player")
# spawn enemy randomly on path2D set outside of player's vision
func spawn_enemy() -> void:
	var enemy = preload("res://orc.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	enemy.global_position = %PathFollow2D.global_position
	add_child(enemy)

# spawn enemy timer
func _on_timer_timeout() -> void:
	spawn_enemy()

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
	if %TimerMobSpawn.wait_time >= 0.1:
		if time_passed >= 10:
			time_passed = 0
			%TimerMobSpawn.wait_time -= 0.1
			
			
func _ready() -> void:
	%TimeLabel.set_text("0:00")
	var item = item_scene.instantiate()
	coin_label()
	
	player.health_depleted.connect(health_changed)
	health_bar.max_value = PlayerStats.max_hp
	health_bar.value = PlayerStats.health
	
func coin_label():
	%CoinLabel.text = str(coins)
	
func health_changed(new_health):
	health_bar.value = new_health
	
#Game over screen
func _on_player_health_depleted() -> void:
	$Menus/GameOver.pause()

#Level up screen
func _on_player_levelup() -> void:
	$Menus/LevelUP.pause()

func _on_coin_collected() -> void:
	coins += 1
	coin_label()
