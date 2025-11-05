extends EnemyTank

class_name Enemy4Tank

func _ready() -> void:
	self.read_for_common()
	velocity = Vector2.ZERO
	self.update_sprite_by_dir(Vector2.DOWN)

func _physics_process(delta: float) -> void:
	self.handle_physics_process(delta)

func _on_move_timer_timeout() -> void:
	self.on_move_timer_timeout($MoveTimer)

func _on_shoot_timer_timeout() -> void:
	self.on_shoot_timer_timeout($ShootTimer)
