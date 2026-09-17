extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# This gets the direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
		# Change animation based on direction
	if is_on_floor():
		if direction == 0: animated_sprite.play("idle")
		else: animated_sprite.play("run")
	
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite based on direction
		if direction > 0: animated_sprite.flip_h = false
		else: animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
