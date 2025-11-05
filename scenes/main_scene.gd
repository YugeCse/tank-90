extends Node2D

# 战场地图
@export
var warMap: WarMap

func _ready() -> void:
	GlobalConfig.reset()

func set_new_stage(stageLevel: int):
	print('', stageLevel)
