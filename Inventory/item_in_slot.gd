extends Panel
class_name ItemInSlot

@onready var item_vis: Sprite2D = $Panel/item_vis

func update(item: InvItems):
	if !item:
		item_vis.visible = false
	else:
		item_vis.visible = true
		item_vis.texture = item.texture
