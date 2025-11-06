extends Node2D

# 战场地图
@export
var warMap: WarMap

@export
var playerTankScene: PackedScene

func _ready() -> void:
	GlobalConfig.reset()
	GlobalEvents.on_enemy_tank_dead_connect(_on_enemy_tank_dead)
	GlobalEvents.on_player_tank_dead_connect(_on_player_tank_dead)
	generate_player_tank() #生成玩家坦克

func set_new_stage(stageLevel: int):
	print('', stageLevel)

## 添加到游戏相机范围
func add_child_to_camera(child: Node):
	$Camera2D.add_child(child)

## 生成玩家坦克
func generate_player_tank():
	var tank = playerTankScene.instantiate() as PlayerTank
	tank.position = Vector2(\
		Constants.DESIGN_CX - 2 * Constants.WAR_SPRITE_SIZE, \
		Constants.DESIGN_CY + Constants.WAR_MAP_SIZE / 2.0 - Constants.WAR_SPRITE_SIZE / 2.0)
	add_child_to_camera(tank)

func _on_player_tank_dead():
	print('玩家被消灭')
	generate_player_tank()

func _on_enemy_tank_dead(type: Enums.TankType):
	print('敌方坦克被消灭: ', type)
