extends Area2D

var level = 1
var pierce = 1 
var speed = 100
var damage = 5
var attacksize = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)	
		
			
func _physics_process(delta) -> void:
		global_position += angle * speed * delta
	
func enemy_hit() -> void:
	pierce -= 1
	if pierce < 0:
		queue_free()

func _on_timer_timeout() -> void: #duration
	queue_free()
