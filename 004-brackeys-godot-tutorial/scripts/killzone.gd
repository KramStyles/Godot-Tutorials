extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5  # Slows stuff down
	# Collider keeps it on the platform. Let the player fall off after dying.
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	# Reload the game
	Engine.time_scale = 1
	get_tree().reload_current_scene()
