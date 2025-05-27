extends Resource

class_name InvItems

enum ItemType {MISC = 0,helmet = 1,chestplate = 2,leggings = 3,boots = 4,necklace = 5,bracelet = 6,ring = 7,belt = 8}

@export var name: String = ""
@export var texture: Texture2D
@export var item_type: ItemType = ItemType.MISC
@export var defence: int
@export var attack: float
@export var hp: float
@export var xp: int
@export var ats: float
@export var buy_price: int
var sell_price: int = 100
@export var rarity: int
