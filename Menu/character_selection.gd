extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()

func _on_soldier_button_down() -> void:
	PlayerStats.damage = 30
	PlayerStats.max_hp = 100
	PlayerStats.health = 100
	resume()
