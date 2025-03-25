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
var elapsed_time := 0
func _on_timer_timeout2() -> void:
	elapsed_time += 1
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	%Label.set_text(str(minutes, ":", seconds if seconds >= 10 else "0" + str(seconds)))

func _ready() -> void:
	%Label.set_text("0:00")
