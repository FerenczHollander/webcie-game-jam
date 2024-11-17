extends Camera2D

@export var node_to_follow: Node2D
var x_offset = -75

func _ready() -> void:
	global_position.x = node_to_follow.global_position.x

func _process(delta: float) -> void:
	global_position.x = global_position.x + (node_to_follow.global_position.x - global_position.x) * 0.2 + x_offset
