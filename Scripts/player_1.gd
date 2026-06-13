extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:

	# Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_W) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement (WASD via code)
	var direction := 0

	if Input.is_key_pressed(KEY_A):
		direction -= 1
		$animation_1.flip_h = true
		$animation_1.play("Walk")
		
	elif Input.is_key_pressed(KEY_D):
		direction += 1
		$animation_1.flip_h = false
		$animation_1.play("Walk")	
	else:
		$animation_1.play("idle")
		
	velocity.x = direction * SPEED

	move_and_slide()
