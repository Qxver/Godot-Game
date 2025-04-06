extends Control

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()
	
func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func _on_damage_button_down() -> void:
	resume()

func _on_attack_speed_button_down() -> void:
	resume()

func _on_health_button_down() -> void:
	resume()
