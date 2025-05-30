extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
	var music = load("res://Assets/Sound/Soundtrack/Main_menu_track.wav")
	SoundManager.play_audio(music)

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()

func _on_human_pressed() -> void:
	PlayerStats.player_base_stats(1)
	PlayerStats.character_id=1
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")


func _on_dwarf_pressed() -> void:
	PlayerStats.player_base_stats(2)
	PlayerStats.character_id=2
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")
