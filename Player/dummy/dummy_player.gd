class_name DummyPlayer
extends Player

@export var animation_sprite: AnimatedSprite2D

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_animation()

func handle_animation():
	
	if velocity == Vector2(0,0):
		animation_sprite.play("default")
		return
	if velocity.x < 0:
		animation_sprite.scale.x = -1
	else:
		animation_sprite.scale.x = 1
	if is_on_floor():
		animation_sprite.play("walking")
	else:
		animation_sprite.play("jumping")
