extends Node2D

class_name EnemyTankFactory

@export
var enemy_tank0_scene: PackedScene

@export
var enemy_tank1_scene: PackedScene

@export
var enemy_tank2_scene: PackedScene

@export
var enemy_tank3_scene: PackedScene

@export
var enemy_tank4_scene: PackedScene

## 任务是否正在进行
var _is_working: bool = false

## 坦克要出生的地点
var born_positions = [
	Vector2(Constants.DESIGN_CX - Constants.WAR_MAP_SIZE/2.0 + Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE/2.0),
	Vector2(Constants.DESIGN_CX, Constants.WAR_SPRITE_SIZE/2.0),
	Vector2(Constants.DESIGN_CX + Constants.WAR_MAP_SIZE/2.0-Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE/2.0),
]

func _ready() -> void:
	pass
	
#func _draw() -> void:
	#var enemy_nodes = get_tree().get_nodes_in_group('PlayerTank')
	#if enemy_nodes.size() > 0:
		#var node = enemy_nodes[0] as BaseTank
		#draw_rect(node.get_global_rect(), Color.AQUA)
	#for born_position in born_positions:
		#var rect = Rect2(born_position - Vector2(Constants.WAR_SPRITE_SIZE/2.0, Constants.WAR_SPRITE_SIZE/2.0),\
			#Vector2(Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE))
		#draw_rect(rect, Color.AQUA)
	#var born_positions = [
		#Vector2(Constants.DESIGN_CX - Constants.WAR_MAP_SIZE/2.0 + Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE/2.0),
		#Vector2(Constants.DESIGN_CX, Constants.WAR_SPRITE_SIZE/2.0),
		#Vector2(Constants.DESIGN_CX + Constants.WAR_MAP_SIZE/2.0-Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE/2.0),
	#]
	#for born_position in born_positions:
		#var rect = Rect2(born_position - Vector2(Constants.WAR_SPRITE_SIZE/2.0, Constants.WAR_SPRITE_SIZE/2.0),\
				#Vector2(Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE))
		#draw_rect(rect, Color.AQUA)

func _on_factory_timer_timeout()->void:
	if _is_working or GlobalConfig.enemy_tank_total_count <= 0: 
			return #任务正在执行or总数量大于0
	_is_working = true
	var enemy_nodes = get_tree().get_nodes_in_group('EnemyTank')
	var diff = GlobalConfig.enemy_tank_per_count - enemy_nodes.size()
	while diff > 0:
		if GlobalConfig.enemy_tank_total_count <= 0:
			break #坦克生产完成，跳出循环
		born_positions.shuffle()
		var born_position = born_positions.pick_random()
		var born_rect = Rect2(born_position - Vector2(Constants.WAR_SPRITE_SIZE/2.0, Constants.WAR_SPRITE_SIZE/2.0),\
				Vector2(Constants.WAR_SPRITE_SIZE, Constants.WAR_SPRITE_SIZE))
		var can_generate = not enemy_nodes.any(func(node):\
			return (node as BaseTank).get_global_rect().intersects(born_rect))
		if can_generate:
			var tank = generate_enemy(born_position)
			enemy_nodes.append(tank)
			diff -= 1
			GlobalConfig.enemy_tank_total_count -= 1
		else: break
	_is_working = false #标记任务已经完成了

## 生成一个坦克并添加到场景里
func generate_enemy(location: Vector2) -> BaseTank:
	var types = Enums.TankType.values()
	types.erase(Enums.TankType.PLAYER)
	var type = types[randi() % types.size()]
	var tank = create_tank(location, type)
	get_tree().current_scene.add_child(tank)
	return tank

## 创建敌方坦克
func create_tank(location: Vector2, type: Enums.TankType) -> EnemyTank:
	assert(type != Enums.TankType.PLAYER)
	if type == Enums.TankType.ENEMY_0:
		var tank = enemy_tank0_scene.instantiate() as Enemy0Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_1:
		var tank = enemy_tank1_scene.instantiate() as Enemy1Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_2:
		var tank = enemy_tank2_scene.instantiate() as Enemy2Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_3:
		var tank = enemy_tank3_scene.instantiate() as Enemy3Tank
		tank.position = location
		return tank
	elif type == Enums.TankType.ENEMY_4:
		var tank = enemy_tank4_scene.instantiate() as Enemy4Tank
		tank.position = location
		return tank
	return null
