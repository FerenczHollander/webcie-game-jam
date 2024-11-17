class_name Player
extends CharacterBody2D

var health = 3
var SPEED = 300.0
var JUMP_VELOCITY_Start = -250.0
var JUMP_VELOCITY = -100.0
var JUMPING = false;
var JUMPFRAMES = 0;
var gravity_modifier = 1.5
var immunity_time = 3
var isImmune = false
var amount_of_groints = 0
@export var animation_sprite: AnimatedSprite2D


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
	print("ahh")
	if body.has_method("getDamage"):
		if velocity.y > 0:
			body.queue_free()
			return
		health -= body.getDamage()
		animation_sprite.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		animation_sprite.modulate = Color.WHITE		
	if body.has_method("getGroints"):
		amount_of_groints += body.getGroints()
		print(amount_of_groints)
		queue_free()
func killPlayer() -> void:
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
