extends Area2D

signal pickup
signal hurt

@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	# Clamp the player from running off the screen
	position.x = clamp(position.x, 25, screensize.x - 20)
	position.y = clamp(position.y, 25, screensize.y - 25)
	# Handle animation
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	# Handle positioning
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		

func start():
	set_process(true)
	position = screensize / 2
	print(position)
	$AnimatedSprite2D.animation = "idle"
	
	
func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)  # Tells Godot to stop calling _process()
	
