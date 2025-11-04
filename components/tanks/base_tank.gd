extends CharacterBody2D

# 坦克基类
class_name BaseTank

# 坦克类型
@export
var tankType: Enums.TankType

# 方向图片
@export
var dirImages: Array[Texture2D]

# 速度
@export
var speed: float = 100.0

# 生命数
@export
var life: int = 1

# 要绑定的精灵对象
@export
var sprite: Sprite2D

# 上一次的有效方向
var _lastEffectiveVelocity: Vector2 = Vector2.UP

# 为玩家的准备逻辑
func ready_for_player():
	set_process_input(true)
	if tankType != Enums.TankType.PLAYER:
		_lastEffectiveVelocity = Vector2.DOWN
	update_sprite_by_dir(_lastEffectiveVelocity)

# 处理方向控制
func handle_input_process_for_player() -> void:
	# 获取输入方向向量（已标准化）
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction
	if input_direction != Vector2.ZERO:
		update_sprite_by_dir(input_direction)
	set_position_limits() # 设置坐标数据限制

# 设置坐标数据限制
func set_position_limits():
	var vCenter = get_viewport().get_visible_rect().get_center()
	var min_posi = Vector2(\
		vCenter.x - Constants.WAR_MAP_SIZE / 2.0,
		vCenter.y - Constants.WAR_MAP_SIZE / 2.0) \
		+ Vector2(Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE)
	var max_posi = Vector2(\
		vCenter.x + Constants.WAR_MAP_SIZE / 2.0,
		vCenter.y + Constants.WAR_MAP_SIZE / 2.0) \
		- Vector2(Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE)
	position = position.clamp(min_posi, max_posi)

# 根据方向更新精灵图片
func update_sprite_by_dir(newDir: Vector2):
	var index = 0
	if newDir == Vector2.UP:
		index = 0
	elif newDir == Vector2.DOWN:
		index = 1
	elif newDir == Vector2.LEFT:
		index = 2
	elif newDir == Vector2.RIGHT:
		index = 3
	else: return # 错误的方向不设置
	_lastEffectiveVelocity = newDir
	sprite.texture = dirImages[index]

# 射击方法
func shoot():
	if _lastEffectiveVelocity == Vector2.ZERO: return
	var bullet: BaseBullet
	if self is PlayerTank:
		bullet = preload("res://components/bullet/PlayerBullet.tscn") \
			.instantiate() as PlayerBullet
	elif self is EnemyTank:
		bullet = preload("res://components/bullet/EnemyBullet.tscn") \
			.instantiate() as EnemyBullet
		if self is Enemy1Tank: #移动最快的坦克
			bullet.speed = 260
	if not bullet: return
	bullet.velocity = _lastEffectiveVelocity
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)

# 受打击
func hitHurt():
	pass

# 大爆炸
func bigBom():
	pass
