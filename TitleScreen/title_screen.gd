extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://level/dummy_level/dummy_level.tscn")
