extends Node

enum TankType {
 PLAYER,
 ENEMY_0,
 ENEMY_1,
 ENEMY_2,
 ENEMY_3,
 ENEMY_4
}

enum MapTileType {
	MUD_WALL,
 	STEEL_WALL,
 	GRASS,
 	RIVER,
 	ICE,
	NONE
}

# 根据数据获取地砖类型
# 1：水泥墙 2：铁墙 3：草 4：水 5：冰 9：家
func get_map_title_type(data: int) -> MapTileType:
	if data == 2:
		return MapTileType.STEEL_WALL
	elif data == 1:
		return MapTileType.MUD_WALL
	elif data == 3:
		return MapTileType.GRASS
	elif data == 4:
		return MapTileType.RIVER
	elif data == 5:
		return MapTileType.ICE
	return MapTileType.NONE
