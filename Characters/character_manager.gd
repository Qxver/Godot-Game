extends Node2D
var current_character = null
var player_ref= null
var if_ready: bool = false

func _ready() -> void:
	await get_tree().process_frame
	set_character(PlayerStats.character_id)
	if_ready=true
	
func set_character(character_id):
	if current_character:
		remove_child(current_character)
		current_character.queue_free()
	match character_id:
		1:
			elf()
		2:
			dwarf()
		3: 
			human()

func elf():
	var elf_scene=preload('res://Characters/Elf.tscn')
	current_character=elf_scene.instantiate()
	current_character.player_ref=player_ref
	add_child(current_character)
	
func dwarf():
	var dwarf_scene=preload('res://Characters/Dwarf.tscn')
	current_character=dwarf_scene.instantiate()
	current_character.player_ref=player_ref
	add_child(current_character)

func human():
	var human_scene=preload('res://Characters/Human.tscn')
	current_character=human_scene.instantiate()
	current_character.player_ref=player_ref
	add_child(current_character)

func attack():
	if not current_character:
		return 
	if not current_character.has_method('attack'):
		return
	current_character.attack()
	
func is_ready():
	if not current_character:
		return false
	if not if_ready:
		return false
	return true
	
	# animation
func animation():
	if is_ready():
		current_character.animation()
func animation_hurt():
	if is_ready():
		current_character.animation_hurt()
func animation_death():
	if is_ready():
		await current_character.animation_death()
		return
