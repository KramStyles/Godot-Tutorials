extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -350.0
@onready var reload_timer: Timer = $ReloadTimer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	shoot()
	

func shoot():
	if Input.is_action_just_pressed("shoot") and reload_timer.time_left == 0:
		print("shoot")
		reload_timer.start()
