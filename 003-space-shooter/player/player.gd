extends RigidBody2D

signal lives_changed
signal dead

@export var engine_power = 500
@export var spin_power = 8000
@export var bullet_scene : PackedScene
@export var fire_rate = 0.25

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = ALIVE
var thrust = Vector2.ZERO
var rotation_dir = 0
var screensize = Vector2.ZERO
var can_shoot = true
var reset_pos = false
var lives = 0: set = set_lives


func set_lives(value):
	lives = value
	lives_changed.emit(lives)
	if lives < 0: change_state(DEAD)
	else: change_state(INVULNERABLE)
	

func reset():
	## Called by Main when a new game starts.
	reset_pos = true
	$Sprite2D.show()
	lives = 3
	change_state(ALIVE)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport_rect().size
	$GunCooldown.wait_time = fire_rate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_input()
	

func get_input():
	thrust = Vector2.ZERO
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed("thrust"):
		thrust = transform.x * engine_power
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
	rotation_dir = Input.get_axis("rotate_left", "rotate_right")
	

func shoot():
	if state == INVULNERABLE:
		return
	can_shoot = false
	$GunCooldown.start()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start($Muzzle.global_transform)
	
	
func _physics_process(delta: float) -> void:
	constant_force = thrust
	constant_torque = rotation_dir * spin_power
	

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	## This code handles screen wrapping (teleporting the body to the opposite 
	## edge of the screen when it moves off-screen, like in Asteroids) 
	## inside Godot's physics engine.
	var xform = _state.transform
	# use wrapf to keep the position bounded between 0 & screensize(x,y).
	# if it moves pass right, teleports to left and vice versa
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	_state.transform = xform
	if reset_pos:
		_state.transform.origin = screensize / 2
		reset_pos = false
	

func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true)
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true)
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
	state = new_state


func _on_gun_cooldown_timeout() -> void:
	can_shoot = true
