extends BaseBullet

class_name EnemyBullet

func _ready() -> void:
	update_sprite_by_direction($Sprite2D, $CollisionShape2D)


func _physics_process(delta: float) -> void:
	handle_physic_process(delta, $CollisionShape2D)