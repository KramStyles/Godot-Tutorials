extends Area2D

var screensize = Vector2.ZERO

func pickup():
	# You can disable collison directly but Godot will alarm
	$CollisionShape2D.set_deferred("disabled", true)
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "scale", scale * .3, 0.3)
	tween.tween_property(self, "modulate:a", 0, 0.3)
	await tween.finished
	queue_free()  # Godot method for removing nodes.
