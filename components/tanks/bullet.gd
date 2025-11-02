extends CharacterBody2D

class_name Bullet

@export
var speed: float = 120

@export
var bulletImgs: Array[AtlasTexture]

func _ready() -> void:
	_update_sprite_by_dir()

func _physics_process(delta: float) -> void:
	var collider = move_and_collide(velocity * speed * delta)
	if not collider: return
	$CollisionShape2D.disabled = true
	queue_free()

# 根据方向更新子弹图案
func _update_sprite_by_dir():
	var index = 0
	var collision_shape = RectangleShape2D.new()
	if velocity == Vector2.UP:
		index = 0
		collision_shape.size = Vector2(4, 5)
	elif velocity == Vector2.DOWN:
		index = 1
		collision_shape.size = Vector2(4, 5)
	elif velocity == Vector2.LEFT:
		index = 2
		collision_shape.size = Vector2(5, 4)
	elif velocity == Vector2.RIGHT:
		index = 3
		collision_shape.size = Vector2(5, 4)
	$Sprite2D.texture = bulletImgs[index]
	$CollisionShape2D.shape = collision_shape