extends Node

## 玩家坦克死亡
signal on_player_tank_dead

## 敌方坦克死亡
signal on_enemy_tank_dead(type: Enums.TankType)


func emit_player_tank_dead_event():
	on_player_tank_dead.emit()

func on_player_tank_dead_connect(callable: Callable):
	on_player_tank_dead.connect(callable)

func on_player_tank_dead_disconnect(callable: Callable):
	on_player_tank_dead.disconnect(callable)
	
func emit_enemy_tank_dead_event(type: Enums.TankType):
	on_enemy_tank_dead.emit(type)

func on_enemy_tank_dead_connect(callable: Callable):
	on_enemy_tank_dead.connect(callable)
	
func on_enemy_tank_dead_disconnect(callable: Callable):
	on_enemy_tank_dead.disconnect(callable)
