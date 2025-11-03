extends AnimatedSprite2D

class_name BulletBom

func _on_animation_finished() -> void:
	queue_free()

# 创建子弹实例
static func create(location: Vector2) -> BulletBom:
	var bom = preload("res://components/bom/BulletBom.tscn").instantiate() as BulletBom
	bom.position = location
	return bom