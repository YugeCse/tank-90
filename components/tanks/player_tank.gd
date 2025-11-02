extends BaseTank

class_name PlayerTank

@onready
var area2d: Area2D = $Area2D

@onready
var collisionShape2d: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	sprite = $Sprite2D
	ready_for_player()

func _physics_process(delta: float) -> void:
	handle_input_process_for_player(delta)
	var collider = move_and_collide(velocity * speed * delta)
	if not collider: return  #如果没有发生碰撞
