extends Control

func _ready() -> void:
	get_tree().create_timer(3.0).timeout.connect(_show_main_scene)
	
func _show_main_scene():
	get_tree().change_scene_to_file("res://scenes/MainScene.tscn")
