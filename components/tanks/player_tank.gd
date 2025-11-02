extends BaseTank

class_name PlayerTank

func _ready() -> void:
	ready_for_player()

func _physics_process(delta: float) -> void:
	handle_input_process_for_player()
	if Input.is_action_just_pressed('ui_shoot'):
		shoot()
	var collider = move_and_collide(velocity * speed * delta)
	if not collider: return # 如果没有发生碰撞
