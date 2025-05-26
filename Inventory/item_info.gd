extends Control

class_name item_info

func display_info(item: InvItems):
	$Panel/Rarity.text = check_rarity(item.rarity)
	$Panel/Type.text = check_type(item.item_type)
	$Panel/Stats.text = "Def + "+str(item.deffence)
	
func check_rarity(x: int):
	match x:
		1:
			var ls = LabelSettings.new()
			ls.font_color = Color8(155,155,155,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Common"))
		2:
			var ls = LabelSettings.new()
			ls.font_color = Color8(20,90,200,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Rare"))
		3:
			var ls = LabelSettings.new()
			ls.font_color = Color8(95,0,160,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Epic"))
		4:
			var ls = LabelSettings.new()
			ls.font_color = Color8(200,210,20,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Legendary"))
		5:
			var ls = LabelSettings.new()
			ls.font_color = Color8(95,0,160,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Amethyst"))
		6:
			var ls = LabelSettings.new()
			ls.font_color = Color8(10,250,10,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Emerald"))
		7:
			var ls = LabelSettings.new()
			ls.font_color = Color8(210,20,10,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Ruby"))
		8:
			var ls = LabelSettings.new()
			ls.font_color = Color8(20,90,200,255)
			ls.font_size = 10
			ls.shadow_color = Color8(0,0,0,255)
			$Panel/Rarity.label_settings = ls
			return(str("Sapphire"))

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
