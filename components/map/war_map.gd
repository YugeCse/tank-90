extends Node2D

class_name WarMap

# 当前关卡
var stage: int

func _ready() -> void:
	if stage < 0:
		stage = 0
	elif stage >= StageLevels.STAGE_MAPS.size():
		stage = StageLevels.STAGE_MAPS.size() - 1
	_drawMapTiles(stage) #绘制地图瓷砖集合

# 绘制地图瓷砖集合
func _drawMapTiles(stageLevel: int):
	var ox = Constants.WAR_MAP_TILE_SIZE / 2.0
	var oy = -Constants.WAR_MAP_TILE_SIZE / 2.0
	var mapTileData = StageLevels.STAGE_MAPS[stageLevel]
	for y in Constants.WAR_MAP_GRID_COUNT:
		for x in Constants.WAR_MAP_GRID_COUNT:
			var data = mapTileData[y][x]
			if data == 0 || data == 9: continue
			var targetPosi = Vector2(\
				ox + x * Constants.WAR_MAP_TILE_SIZE,
				oy + y * Constants.WAR_MAP_TILE_SIZE)
			var type = Enums.get_map_title_type(data)
			if type == Enums.MapTileType.NONE:
				continue
			var tile = BaseMapTile.createMapTile(type)
			tile.position = targetPosi
			add_child(tile) #添加瓷砖绘制
