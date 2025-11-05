extends Node2D

class_name EnemyTankFactory

func _ready() -> void:
	pass

func _on_factory_timer_timeout()->void:
	pass

func generateEnemy():
	var types = Enums.TankType.values()
	var type = types[randi() % types.size()]
	if type == Enums.TankType.ENEMY_0:
		pass
	elif type == Enums.TankType.ENEMY_1:
		pass
	elif type == Enums.TankType.ENEMY_2:
		pass
	elif type == Enums.TankType.ENEMY_3:
		pass
	elif type == Enums.TankType.ENEMY_4:
		pass