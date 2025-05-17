extends Resource

class_name InvItems

enum ItemType {MISC = 0,helmet = 1,chestplate = 2,leggings = 3,boots = 4,necklace = 5,bracelet = 6,ring = 7,belt = 8}

@export var name: String = ""
@export var texture: Texture2D
@export var item_type: ItemType = ItemType.MISC
@export var deffence: int
@export var attack: int
@export var hp: int
@export var xp: int
@export var ats: int
@export var buy_price: int
@export var sell_price: int
