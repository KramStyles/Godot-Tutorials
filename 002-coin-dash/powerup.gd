extends Area2D

var screensize = Vector2.ZERO

func pickup():
	$CollisionShape2D.set_deferred("disabled", true)
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate:a", 0, 0.3)
	tween.tween_property(self, "scale", scale * .6, .3)
	await tween.finished
	queue_free()
	
	
func _on_life_time_timeout() -> void:
	queue_free()
