extends Node2D

# 战场地图
@export
var warMap: WarMap

func _ready() -> void:
	GlobalConfig.reset()
	GlobalEvents.on_player_tank_dead\
		.connect(_on_player_tank_dead)
	GlobalEvents.on_enemy_tank_dead\
		.connect(_on_enemy_tank_dead)

func set_new_stage(stageLevel: int):
	print('', stageLevel)

func _on_player_tank_dead():
	print('玩家被消灭')

func _on_enemy_tank_dead(type: Enums.TankType):
	print('敌方坦克被消灭: ', type)
