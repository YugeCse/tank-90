extends CharacterBody2D

class_name BaseBullet

@export
var speed: float = 150

@export
var bulletImgs: Array[AtlasTexture]

# 处理物理逻辑
func handle_physic_process(\
	delta: float, \
	collisionShape: CollisionShape2D) -> void:
	var shape_size = (collisionShape.shape as RectangleShape2D).size
	var min_x = Constants.DESIGN_WIDTH / 2.0 - Constants.WAR_MAP_SIZE / 2.0
	var max_x = Constants.DESIGN_WIDTH / 2.0 + Constants.WAR_MAP_SIZE / 2.0
	var min_y = Constants.DESIGN_HEIGHT / 2.0 - Constants.WAR_MAP_SIZE / 2.0
	var max_y = Constants.DESIGN_HEIGHT / 2.0 + Constants.WAR_MAP_SIZE / 2.0
	if position.x <= min_x + 2 * shape_size.x or \
		position.x >= max_x - 2 * shape_size.x or \
		position.y <= min_y + 2 * shape_size.y or \
		position.y >= max_y - 2 * shape_size.y:
			show_bom_effect(position) # 超出边界了
	var collider = move_and_collide(velocity * speed * delta)
	if not collider: return
	collisionShape.disabled = true
	var target_collider = collider.get_collider()
	if target_collider:
		if target_collider is StaticBody2D:
			var parent = target_collider.get_parent()
			if parent is MudWallMapTile:
				parent.queue_free()
			elif parent is RiverMapTile: return
			elif parent is IceMapTile: return
		elif target_collider is CharacterBody2D:
			if target_collider is BaseTank:
				print('子弹与坦克发生碰撞')
	show_bom_effect(position) # 从树节点上删除

# 根据方向更新子弹图案
func update_sprite_by_direction(\
	sprite: Sprite2D, \
	collisionShape: CollisionShape2D):
	var index = 0
	var collision_shape = RectangleShape2D.new()
	if velocity == Vector2.UP:
		index = 0
		collision_shape.size = Vector2(4, 5)
	elif velocity == Vector2.DOWN:
		index = 1
		collision_shape.size = Vector2(4, 5)
	elif velocity == Vector2.LEFT:
		index = 2
		collision_shape.size = Vector2(5, 4)
	elif velocity == Vector2.RIGHT:
		index = 3
		collision_shape.size = Vector2(5, 4)
	sprite.texture = bulletImgs[index]
	collisionShape.shape = collision_shape

func show_bom_effect(location: Vector2):
	velocity = Vector2.ZERO
	queue_free() # 直接从节点中删除
	get_tree().current_scene.add_child(BulletBom.create(location))
