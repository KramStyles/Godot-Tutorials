extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TimeLabel.text = Global.user_score
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
