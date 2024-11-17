extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const direction = -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
	velocity.x = direction * SPEED

	move_and_slide()