extends CharacterBody2D


@export var SPEED = 100.0
@export var MOVE_DISTANCE = 100
var direction = 1
var damage = 1
var start_pos: int

func _ready() -> void:
	start_pos = position.x

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta 
	else:
		velocity.x = SPEED*direction
		if (position.x - start_pos) < 0:
			direction = 1
			position.x = start_pos
		elif (position.x - start_pos) > MOVE_DISTANCE:
			direction = -1
			position.x = MOVE_DISTANCE+start_pos
			
	move_and_slide()
func getDamage() -> int:
	return damage
	
