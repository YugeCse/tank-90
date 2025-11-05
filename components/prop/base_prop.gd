extends Sprite2D

class_name BaseProp

## 得分
@export
var score: int

## 精灵对象
@export
var sprite: Sprite2D

## 道具类型
@export
var type: Enums.PropType

## 道具图片资源
@export
var propAtlasTextures: Dictionary = {}

## 动画对象
var _blink_tween: Tween

func update_sprite():
	assert(type != null)
	sprite.texture = propAtlasTextures[type]

## 开始闪烁
func start_blink():
	_blink_tween = create_tween()
	_blink_tween.set_loops()  # 无限循环
	
	# 透明度闪烁：1 → 0 → 1
	_blink_tween.tween_property(self, "modulate:a", 0.0, 0.5)
	_blink_tween.tween_property(self, "modulate:a", 1.0, 0.5)

## 停止闪烁
func stop_blink():
	if _blink_tween:
		_blink_tween.kill()
		modulate.a = 1.0  # 恢复不透明
