extends Control

signal as_up

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()
	InputMap.load_from_project_settings()
	
func pause():
	show()
	InputMap.action_erase_events("esc")
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func _on_damage_button_down() -> void:
	PlayerStats.damage += 10
	resume()

func _on_attack_speed_button_down() -> void:
	as_up.emit()
	resume()

func _on_health_button_down() -> void:
	PlayerStats.max_hp += 20
	
	resume()
