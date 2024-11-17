class_name DummyPlayer
extends Player

var jump_max = 2
var jump_counter = 0


func _ready():
	pass

func _physics_process(delta: float) -> void:
	handle_jump(delta)
	handle_movement(delta)
	handle_animation()
func handle_jump(delta):
	if Input.is_action_just_pressed("ui_accept") and jump_counter < jump_max-1:
		JUMPFRAMES = 0
		jump_counter += 1;
		velocity.y = JUMP_VELOCITY_Start
	elif Input.is_action_pressed("ui_accept") and JUMPFRAMES < 10:
		JUMPFRAMES += 1
		velocity.y += JUMP_VELOCITY / JUMPFRAMES
		velocity.y = max(velocity.y, -600.0)
	if is_on_floor():
		jump_counter = 0
		JUMPFRAMES = 0
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
