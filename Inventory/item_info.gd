extends Control

class_name item_info

func display_info(item: InvItems):
	$Panel/Rarity.text = str(item.name)
	$Panel/Type.text = str(item.item_type)
	$Panel/Stats.text = "Def + "+str(item.deffence)
	
func check_rarity(item: InvItems):
	pass
