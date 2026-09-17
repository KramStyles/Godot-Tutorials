extends Area2D

# This would work because the game manager and coins are called in the same scene (main). 
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	#queue_free()  # Not using queue free. Let's call from animation player
	animation_player.play("pickup")
