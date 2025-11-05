extends BaseProp

class_name TankProp

func _ready() -> void:
	update_sprite()
	start_blink() #开始执行闪烁
