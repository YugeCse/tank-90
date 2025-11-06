extends Node

## 玩家坦克死亡
signal on_player_tank_dead

## 敌方坦克死亡
signal on_enemy_tank_dead(type: Enums.TankType)
