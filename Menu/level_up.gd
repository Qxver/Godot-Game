extends Control

signal as_up

func _ready():
	hide()
	$AnimationPlayer.play("RESET")


func resume():
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()
	InputMap.load_from_project_settings()
	get_tree().paused = false
	
func pause():
	show()
	InputMap.action_erase_events("esc")
	InputMap.action_erase_events("inv")
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func _on_damage_button_down() -> void:
	PlayerStats.base_dmg += 10
	PlayerStats.update_stats()
	resume()

func _on_attack_speed_button_down() -> void:
	as_up.emit()
	resume()

func _on_health_button_down() -> void:
	PlayerStats.base_hp += 20
	PlayerStats.update_stats()
	resume()
