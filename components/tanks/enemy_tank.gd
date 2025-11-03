extends BaseTank

class_name EnemyTank

# 所有方向的集合
var _all_dirs = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func _physics_process(delta: float) -> void:
	self.set_position_limits()
	var collider = move_and_collide(velocity * speed * delta)
	if not collider: return
	if collider and collider is BaseTank:
		velocity = Vector2.ZERO
		collider.velocity = Vector2.ZERO

func _on_move_timer_timeout() -> void:
	var next_dir = _all_dirs[randi() % 4]
	velocity = next_dir # 设置当前的方向
	self.update_sprite_by_dir(next_dir) # 更新当前精灵图片
