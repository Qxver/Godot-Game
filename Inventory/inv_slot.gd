extends Button

class_name Slot

@onready var itemVis: Sprite2D = $CenterContainer/Panel/item_vis
var itemInSlot: InvItems
var frame = preload("res://Assets/Menu_assets/item_frame.png")
var frame_selected = preload("res://Assets/Menu_assets/item_frame_empty.png")
signal equip

func update(item: InvItems):
	if !item:
		itemVis.visible = false
		itemInSlot = null
		$Frame.texture = frame_selected
		
	else:
		itemInSlot = item
		$Frame.texture = frame
		itemVis.texture = item.texture
		itemVis.visible = true

func _on_mouse_entered():
	if itemInSlot == null:
		return
	$ItemInfo.display_info(itemInSlot)
	$ItemInfo.visible = true
	$Frame.texture = frame_selected

func _on_mouse_exited():
	$ItemInfo.visible = false
	if itemInSlot:
		$Frame.texture = frame
	else:
		$Frame.texture = frame_selected
	
func _on_button_down():
	if itemInSlot == null:
		return
	$Click.visible = true

func _on_button_up():
	if itemInSlot == null:
		return
	$Click.visible = false
	emit_signal("equip",itemInSlot)
	$ItemInfo.visible = false
