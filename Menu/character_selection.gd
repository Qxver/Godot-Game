extends Control
var click_sound = preload("res://Assets/Sound/Effects/mixkit-modern-technology-select-3124.wav")  

func _ready():
	$AnimationPlayer.play("RESET")
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	SoundManager.Soundtrack1Progress = SoundManager.soundtrack.get_playback_position()
	SoundManager.play_soundtrack1()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()

func _on_human_pressed() -> void:
	SoundManager.play_audio(click_sound)
	PlayerStats.player_base_stats(1)
	PlayerStats.character_id=1
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")


func _on_dwarf_pressed() -> void:
	SoundManager.play_audio(click_sound)
	PlayerStats.player_base_stats(2)
	PlayerStats.character_id=2
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")
