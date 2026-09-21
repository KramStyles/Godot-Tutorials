extends Area2D

var direction := Vector2.RIGHT
var speed = 4

@onready var sprite_2d: Sprite2D = $Sprite2D

func set_car_region(region: Rect2) -> void:
	## Duplicate the AtlasTexture so each car gets its own independent region
	if sprite_2d.texture is AtlasTexture:
		sprite_2d.texture = sprite_2d.texture.duplicate()
		var atlas_tex = sprite_2d.texture as AtlasTexture
		atlas_tex.region = region


func _process(delta: float) -> void:
	position += direction * speed
	

func _ready() -> void:
	if position.x > 0:
		direction = Vector2.LEFT
		rotate(3.15)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Destroy the car as soon as it leaves the scene
	queue_free()
