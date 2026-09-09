extends Area2D

var screensize = Vector2.ZERO

func pickup():
	queue_free()  # Godot method for removing nodes.
