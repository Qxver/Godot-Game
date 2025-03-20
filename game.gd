extends Node2D

func spawn_orc() -> void:
	var orc = preload("res://orc.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	orc.global_position = %PathFollow2D.global_position
	add_child(orc)

func _on_timer_timeout() -> void:
	spawn_orc()
