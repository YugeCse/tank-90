extends Node

## 当前关卡
var current_stage = 0

## 玩家生命数
var player_life = 3

## 玩家得分
var player_score = 0

## 敌方坦克每批次最大坦克数量：5
var enemy_tank_per_count = 5

## 敌方坦克总数: 20
var enemy_tank_total_count = 20

## 重置数据
func reset():
	current_stage = 0
	player_life = 3
	player_score = 0
	enemy_tank_per_count = 5
	enemy_tank_total_count = 20
