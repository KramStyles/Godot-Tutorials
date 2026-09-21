extends Area2D

var direction := Vector2.RIGHT
var speed = 2


func _process(delta: float) -> void:
	position += direction * speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Destroy the car as soon as it leaves the scene
	queue_free()
