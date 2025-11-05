extends BaseTank

class_name EnemyTank

# 所有方向的集合
var _all_dirs = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func handle_physics_process(delta: float) -> void:
	self.set_position_limits()
	var collider = move_and_collide(velocity * speed * delta)
	if not collider: return
	if collider and collider is BaseTank:
		velocity = Vector2.ZERO
		collider.velocity = Vector2.ZERO

func on_move_timer_timeout(timer: Timer) -> void:
	var next_dir = _all_dirs[randi() % 4]
	velocity = next_dir # 设置当前的方向
	_lastEffectiveVelocity = next_dir
	self.update_sprite_by_dir(next_dir) # 更新当前精灵图片
	timer.wait_time = randi() % 5 + 1

func on_shoot_timer_timeout(timer: Timer) -> void:
	shoot()
	timer.wait_time = randi() % 5 + 1

## 创建敌方坦克
static func create(location: Vector2, type: Enums.TankType) -> EnemyTank:
	assert(type != Enums.TankType.PLAYER)
	if type == Enums.TankType.ENEMY_0:
		var tank = preload('res://components/tanks/Enemy0Tank.tscn')\
			.instantiate() as Enemy0Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_1:
		var tank = preload("res://components/tanks/Enemy1Tank.tscn")\
			.instantiate() as Enemy1Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_2:
		var tank = preload("res://components/tanks/Enemy2Tank.tscn")\
			.instantiate() as Enemy2Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_3:
		var tank = preload('res://components/tanks/Enemy3Tank.tscn')\
			.instantiate() as Enemy3Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_4:
		var tank = preload('res://components/tanks/Enemy4Tank.tscn')\
			.instantiate() as Enemy4Tank
		tank.position = location
		return tank
	return null
