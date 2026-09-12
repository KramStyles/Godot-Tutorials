extends RigidBody2D

signal exploded

var screensize = Vector2.ZERO
var size
var radius
var scale_factor = 0.2


func explode():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	$ExplosionNode/AnimationPlayer.play("explosion")
	$ExplosionNode/Explosion.show()
	exploded.emit(size, radius, position, linear_velocity)
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	await $ExplosionNode/AnimationPlayer.animation_finished
	queue_free()


func start(_position, _velocity, _size):
	position = _position
	size = _size
	mass = 1.5 * size
	$Sprite2D.scale = Vector2.ONE * scale_factor * size
	radius = int($Sprite2D.texture.get_size().x / 2 * $Sprite2D.scale.x)
	var shape = CircleShape2D.new()
	shape.radius = radius
	$CollisionShape2D.shape = shape
	linear_velocity = _velocity
	angular_velocity = randf_range(-PI, PI)
	# Explosion node
	$ExplosionNode.scale = Vector2.ONE * size * 0.75
	

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	var xform = _state.transform
	# use wrapf to keep the position bounded between 0 & screensize(x,y).
	# if it moves pass right, teleports to left and vice versa
	xform.origin.x = wrapf(xform.origin.x, 0 - radius, screensize.x + radius)
	xform.origin.y = wrapf(xform.origin.y, 0 - radius, screensize.y + radius)
	_state.transform = xform
