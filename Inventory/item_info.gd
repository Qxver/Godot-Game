extends Control

class_name item_info

func display_info(item: InvItems):
	$Panel/Rarity.text = check_rarity(item.rarity)
	$Panel/Type.text = check_type(item.item_type)
	$Panel/Stats.text = "Def + "+str(item.deffence)
	
func check_rarity(x: int):
	match x:
		1:
			return(str("Helmet"))
		2:
			return(str("Chestplate"))
		3:
			return(str("Leggings"))
		4:
			return(str("Boots"))

func check_type(x: int):
	match x:
		1:
			return(str("Helmet"))
		2:
			return(str("Chestplate"))
		3:
			return(str("Leggings"))
		4:
			return(str("Boots"))
		5:
			return(str("Necklace"))
		6:
			return(str("Bracelet"))
		7:
			return(str("Ring"))
		8:
			return(str("Belt"))
