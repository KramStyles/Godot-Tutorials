extends Node2D

var car_scene: PackedScene = preload("res://scenes/car.tscn")
var time_started := 0
var is_alive := true
@onready var time_label: Label = $CanvasLayer/TimeLabel

const CAR_REGIONS: Array[Rect2] = [
	Rect2(20, 18, 67, 130),    # Car 1
	Rect2(150, 18, 67, 130),    # Car 2
	Rect2(265, 18, 67, 130),    # Car 3
	Rect2(375, 18, 67, 130),    # Car 4
	Rect2(490, 18, 67, 130),    # Car 5
	
	Rect2(20, 180, 67, 130),    # Car 6
	Rect2(150, 180, 67, 130),    # Car 7
	Rect2(265, 180, 67, 130),    # Car 8
	Rect2(375, 180, 67, 130),    # Car 9
	Rect2(490, 180, 67, 130),    # Car 10
]


func go_to_title(body):
	body.animated_sprite.play("die")
	print(body.animated_sprite.animation)
	# Not working
	#await body.animated_sprite.animation_finished


func _on_car_timer_timeout() -> void:
	var car : Area2D = car_scene.instantiate()
	var random_region = CAR_REGIONS.pick_random()
	# Set starting position
	var pos_marker = $CarStartPositions.get_children().pick_random() as Marker2D
	car.position = pos_marker.position
	$Objects.add_child(car)
	car.set_car_region(random_region)
	car.connect("body_entered", go_to_title)
	

func _on_finish_area_body_entered(body: Node2D) -> void:
	print("Hurray")


func _on_time_timer_timeout() -> void:
	if is_alive:
		time_started += 1
	time_label.text = "Time: {time}".format({"time": time_started})
