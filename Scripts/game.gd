extends Node2D

@onready var game = $"."
@onready var player = $Player
@onready var death_menu = $CanvasLayer/DeathMenu
@onready var upgrade_menu = $CanvasLayer/UpgradeMenu
@onready var victory_menu = $CanvasLayer/VictoryMenu
@onready var camera_2d = $Player/Camera2D

const POND = preload("res://Scenes/pond.tscn")


func _on_main_ui_victory():
	victory_menu.show()
	get_tree().paused = true


func _on_player_player_death():
	death_menu.show()
	get_tree().paused = true


func _on_player_level_up():
	upgrade_menu.randomize_upgrades() # randomize 3 upgrades from available pool for player to choose
	Global.upgrade_pause = true
	upgrade_menu.show()
	get_tree().paused = true # bug where resumes if you have both pause menu and upgrade menu open


func _on_water_timer_timeout():
	
	# get random coordinate in range around player, then spawn pool of water
	# to exclude area that player is in, generate two ranges on either side

	var rand_x_left = randi_range(player.global_position.x - 200, player.global_position.x - 400)
	var rand_x_right = randi_range(player.global_position.x + 200, player.global_position.x + 400)
	var rand_y_top = randi_range(player.global_position.y - 200, player.global_position.y - 400)
	var rand_y_bottom = randi_range(player.global_position.y + 200, player.global_position.y + 400)
	
	var x_num = randi_range(0,1)
	var rand_x
	if x_num == 0:
		rand_x = rand_x_left
	else:
		rand_x = rand_x_right
	var y_num = randi_range(0,1)
	var rand_y
	if y_num == 0:
		rand_y = rand_y_top
	else:
		rand_y = rand_y_bottom
	
	var rand_position = Vector2(rand_x, rand_y)
	var pond = POND.instantiate()
	pond.global_position = rand_position
	game.add_child(pond)
