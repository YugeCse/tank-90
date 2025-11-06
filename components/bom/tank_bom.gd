extends AnimatedSprite2D

class_name TankBom

func _on_animation_finished() -> void:
	queue_free()
	
	
static func create(location: Vector2) -> TankBom:
	var bom = load("res://components/bom/TankBom.tscn")\
		.instantiate() as TankBom
	bom.position = location
	return bom
