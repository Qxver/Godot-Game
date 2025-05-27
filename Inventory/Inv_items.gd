extends Resource

class_name InvItems

enum ItemType {MISC = 0,helmet = 1,chestplate = 2,leggings = 3,boots = 4,necklace = 5,bracelet = 6,ring = 7,belt = 8}

@export var name: String = ""
@export var texture: Texture2D
@export var item_type: ItemType = ItemType.MISC
@export var deffence: int
@export var attack= 1.0
@export var hp = 1.0
@export var xp: int
@export var ats= 1.0
@export var buy_price: int
var sell_price: int = 100
@export var rarity: int
