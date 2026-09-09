extends Node

@export var coin_scene : PackedScene
@export var power_up_scene : PackedScene
@export var playtime = 30

var level = 1
var score = 0
var time_left = 0
var screensize = Vector2.ZERO
var playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	
func check_remaining_coins():
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		spawn_coins()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_remaining_coins()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start()
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	# Update HUD
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	
	
func spawn_coins():
	$LevelSound.play()
	for i in level + 4:
		var coin = coin_scene.instantiate()
		add_child(coin)
		coin.screensize = screensize
		coin.position = Vector2(
			randi_range(20, screensize.x), 
			randi_range(20, screensize.y)
		)
		
		
func game_over():
	playing = false
	$GameTimer.stop()
	$EndSound.play()
	get_tree().call_group("coins", "queue_free")
	$HUD.show_game_over()
	$Player.die()


func _on_game_timer_timeout() -> void:
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_player_hurt() -> void:
	game_over()


func _on_player_pickup(type) -> void:
	match type:
		"coin":
			score += 1
			$CoinSound.play()
			$HUD.update_score(score)
		"powerup":
			$PowerUpSound.play()
			time_left += 5
			$HUD.update_timer(time_left)


func _on_hud_start_game() -> void:
	new_game()


func _on_power_up_timer_timeout() -> void:
	var power_up = power_up_scene.instantiate()
	add_child(power_up)
	power_up.screensize = screensize
	power_up.position = Vector2(
		randi_range(20, screensize.x - 20),
		randi_range(50, screensize.y - 20)
	)
