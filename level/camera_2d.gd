extends Camera2D

@export var node_to_follow: Node2D


func _process(delta: float) -> void:
	global_position.x = global_position.x + (node_to_follow.global_position.x - global_position.x) * 0.2
