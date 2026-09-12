extends Node2D


@export var rock_scene : PackedScene
var screensize = Vector2.ZERO


func _on_rock_exploded(size, radius, pos, vel):
	if size <= 1: return
	for offset in [-1, 1]:
		var dir = $Player.position.direction_to(pos).orthogonal() * offset
		var new_pos = pos + (dir * radius)
		var new_val = dir * vel.length() * 1.1
		spawn_rock(size - 1, new_pos, new_val)


func spawn_rock(size, pos=null, vel=null):
	if pos == null:
		$RockPath/RockSpawn.progress = randi()
		pos = $RockPath/RockSpawn.position
		
	if vel == null:
		vel = Vector2.RIGHT.rotated(randf_range(0, TAU)) * randf_range(50, 125)
		
	var rock = rock_scene.instantiate()
	rock.screensize = screensize
	rock.exploded.connect(self._on_rock_exploded)
	rock.start(pos, vel, size)
	call_deferred("add_child", rock)


func _ready():
	screensize = get_viewport().get_visible_rect().size
	for num in 3:
		spawn_rock(3)
