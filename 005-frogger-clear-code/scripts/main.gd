extends Node2D

var car_scene: PackedScene = preload("res://scenes/car.tscn")



func _on_finish_area_body_entered(body: Node2D) -> void:
	print(body, "has entered")


func _on_car_timer_timeout() -> void:
	var car = car_scene.instantiate()
	$Objects.add_child(car)
	print("heyyy")
