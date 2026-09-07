extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
# Let's rotate the label
func let_us_rotate(label: Label) -> void:
	#  1 radian = 57.2958
	var rot = 1
	label.set_rotation(rot)
	var rot_degree = rot * 180 / PI
	print("hi ", rot_degree)


func _on_button_pressed() -> void:
	var pos = Vector2(50, 10)
	var label = $Label
	label.set_position(pos)
	label.set_text("Hiiiiiii")
	let_us_rotate($Label)
