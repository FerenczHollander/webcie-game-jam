class_name Player
extends CharacterBody2D

var health = 3
var SPEED = 300.0
var JUMP_VELOCITY_Start = -250.0
var JUMP_VELOCITY = -100.0
var JUMPING = false;
var JUMPFRAMES = 0;
var gravity_modifier = 1.5

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_jump(delta)

func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_modifier
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if (health <= 0):
		killPlayer()
	move_and_slide()
	
func handle_jump(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not JUMPING:
		JUMPING = true;
		velocity.y += JUMP_VELOCITY_Start
	elif Input.is_action_pressed("ui_accept") and JUMPING and JUMPFRAMES < 10:
		JUMPFRAMES += 1
		velocity.y += JUMP_VELOCITY / JUMPFRAMES
		velocity.y = max(velocity.y, -600.0)
	else:
		JUMPING = false
		JUMPFRAMES = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("getDamage"):
		health -= body.getDamge()
		
func killPlayer() -> void:
	pass
