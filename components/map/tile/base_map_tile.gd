extends Sprite2D

class_name BaseMapTile

@export
var tileType: Enums.MapTileType


static func createMapTile(type: Enums.MapTileType)->BaseMapTile:
	if type == Enums.MapTileType.MUD_WALL:
		var tile = preload('res://components/map/tile/MudWallMapTile.tscn')
		return tile.instantiate() as MudWallMapTile
	elif type == Enums.MapTileType.STEEL_WALL:
		var tile = preload('res://components/map/tile/SteelWallMapTile.tscn')
		return tile.instantiate() as SteelWallMapTile
	elif type == Enums.MapTileType.GRASS:
		var tile = preload('res://components/map/tile/GrassMapTile.tscn')
		return tile.instantiate() as GrassMapTile
	elif type == Enums.MapTileType.RIVER:
		var tile = preload('res://components/map/tile/RiverMapTile.tscn')
		return tile.instantiate() as RiverMapTile
	elif type == Enums.MapTileType.ICE:
		var tile = preload('res://components/map/tile/IceMapTile.tscn')
		return tile.instantiate() as IceMapTile
	return null
	
