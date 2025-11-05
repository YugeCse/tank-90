extends Node2D

class_name EnemyTankFactory

var _is_working: bool = false

func _ready() -> void:
	pass

func _on_factory_timer_timeout()->void:
	if _is_working: return
	_is_working = true
	var enemy_nodes = get_tree()\
		.get_nodes_in_group('EnemyTank')
	var diff = GlobalConfig.enemy_tank_per_count - enemy_nodes.size()
	if diff <= 0: 
		_is_working = false
		return
	var born_positions = [
		Vector2(Constants.DESIGN_CX - Constants.WAR_MAP_SIZE/2.0 + Constants.WAR_SPRITE_SIZE/2.0, Constants.WAR_SPRITE_SIZE/2.0),
		Vector2(Constants.DESIGN_CX, Constants.WAR_SPRITE_SIZE/2.0),
		Vector2(Constants.DESIGN_CX + Constants.WAR_MAP_SIZE/2.0-Constants.WAR_SPRITE_SIZE/2.0, Constants.WAR_SPRITE_SIZE/2.0),
	]
	while diff > 0:
		for born_position in born_positions:
			var rect = Rect2(born_position - Vector2(Constants.WAR_SPRITE_SIZE/2.0, Constants.WAR_SPRITE_SIZE/2.0),\
				Vector2(Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE))
			if check_rect_area_2d(rect):
				generate_enemy(born_position)
				diff -= 1
	_is_working = false # 生产任务完成

## 生成一个坦克并添加到场景里
func generate_enemy(location: Vector2):
	var types = Enums.TankType.values()
	types.erase(Enums.TankType.PLAYER)
	var type = types[randi() % types.size()]
	var tank = EnemyTank.create(location, type)
	get_tree().current_scene.add_child(tank)
	
# 检测矩形范围内是否有碰撞体
func check_rect_area_2d(rect: Rect2, collision_mask: int = 0x7FFFFFFF) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	
	# 创建矩形形状
	var rectangle_shape = RectangleShape2D.new()
	rectangle_shape.size = rect.size
	
	query.shape = rectangle_shape
	query.transform = Transform2D(0, rect.position + rect.size * 0.5)  # 中心位置
	query.collision_mask = collision_mask
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var result = space_state.intersect_shape(query)
	return not result.is_empty()
	
