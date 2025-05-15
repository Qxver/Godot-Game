extends Button

@onready var container: CenterContainer = $CenterContainer
var itemInSlot: ItemInSlot

func insert(iis: ItemInSlot):
	itemInSlot = iis
	container.add_child(itemInSlot)
