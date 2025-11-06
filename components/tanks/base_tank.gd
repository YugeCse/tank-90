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

var audioPlayer: AudioStreamPlayer

# 上一次的有效方向
var _lastEffectiveVelocity: Vector2 = Vector2.UP

func read_for_common():
	audioPlayer = AudioStreamPlayer.new()
	add_child(audioPlayer)

# 为玩家的准备逻辑
func ready_for_player():
	read_for_common()
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
	
func get_global_rect() -> Rect2:
	# 获取精灵的本地矩形，然后转换为全局坐标
	var local_rect = sprite.get_rect()
	var global_pos = sprite.global_position
	
	# 根据 centered 属性调整矩形位置
	if sprite.centered:
		# 中心锚点：矩形从中心向四周扩展
		return Rect2(global_pos - local_rect.size * 0.5, local_rect.size)
	else:
		# 左上角锚点：矩形从位置点开始
		return Rect2(global_pos, local_rect.size)

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
func hurt():
	if life > 0:
		life-=1
	if life != 0:
		audioPlayer.stream = load("res://resources/audio/attack.mp3")
		audioPlayer.play()
	else: bigBom()

# 大爆炸
func bigBom():
	get_tree().current_scene\
		.add_child(TankBom.create(position))
	if self is EnemyTank:
		audioPlayer.stream = load("res://resources/audio/tankCrack.mp3")
		GlobalEvents.on_enemy_tank_dead.emit(self.tankType)
	elif self is PlayerTank:
		audioPlayer.stream = load('res://resources/audio/playerCrack.mp3')
		GlobalEvents.on_player_tank_dead.emit()
	audioPlayer.play()
	queue_free() #从节点中删除
