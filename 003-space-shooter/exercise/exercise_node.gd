extends Node2D

var exercise_direction := Vector2(1, -1)  # Right and Upward
var exercise_speed := 5
@onready var rock: Sprite2D = $Rock


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rock.position += exercise_direction * exercise_speed
	var height: int = get_window().size.y
	var width: int = get_window().size.x
	if rock.position.y <= 0: exercise_direction.y = 1
	if rock.position.y >= height: exercise_direction.y = -1
	if rock.position.x <= 0: exercise_direction.x = 1
	if rock.position.x >= width: exercise_direction.x = -1
