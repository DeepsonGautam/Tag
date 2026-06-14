extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -500.0


var is_tagged = false

func set_tagged(value: bool):
	is_tagged = value
	$Arrow.visible = is_tagged


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := 0

	if Input.is_key_pressed(KEY_LEFT):
		direction -= 1
		$animation_2.flip_h = true
		$animation_2.play("walk")
		
	elif Input.is_key_pressed(KEY_RIGHT):
		direction += 1
		$animation_2.flip_h = false
		$animation_2.play("walk")	
	else:
		$animation_2.play("idle")
		
	velocity.x = direction * SPEED

	move_and_slide()
