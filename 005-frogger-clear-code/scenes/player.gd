extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED := 100.0
var direction = Vector2.ONE
var is_dead := false


func die():
	is_dead = true
	animated_sprite.play("die")


func _physics_process(delta: float) -> void:
	if is_dead: return

	# This gets the direction: -1, 0, 1
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		position += direction * SPEED * delta
		if direction.x != 0:
			animated_sprite.play("running-x")
			animated_sprite.flip_h = !direction.x > 0
			#if direction.x > 0: animated_sprite.flip_h = false
			#elif direction.x < 0: animated_sprite.flip_h = true
		else:
			animated_sprite.play("running-x") if direction.y > 0 else animated_sprite.play("running-up")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()
