extends Node2D

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
	%Label.set_text(str(minutes, ":", seconds if seconds >= 10 else "0" + str(seconds)))

func _ready() -> void:
	%Label.set_text("0:00")
	
# change mob spawn time -0.1s every 10s elapsed time
var time_passed = 0
func _physics_process(delta: float) -> void:
	time_passed += delta
	if %TimerMobSpawn.wait_time >= 0.1:
		if time_passed >= 10:
			time_passed = 0
			%TimerMobSpawn.wait_time -= 0.1
