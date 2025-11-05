extends Node2D

# 战场地图
@export
var warMap: WarMap

func _ready() -> void:
	var nodes = get_tree().get_nodes_in_group("EnemyTank")
	print('敌方坦克数量：', nodes.size())

func set_new_stage(stageLevel: int):
	print('', stageLevel)
