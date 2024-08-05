extends Node2D

@onready var game = get_tree().get_first_node_in_group("game")
@onready var growth_timer = $GrowthTimer
@onready var growth_progress = $GrowthProgress
@onready var growth_progress_bar = $GrowthProgress/GrowthProgressBar
@onready var water_progress = $WaterProgress
@onready var water_progress_bar = $WaterProgress/WaterProgressBar
@onready var sprite_2d = $Sprite2D

var water_needed = 50
var water_amount = 0.0
var time = 10

const TREE = preload("res://Scenes/tree.tscn")

func _process(_delta):
	
	growth_progress_bar.value = time - growth_timer.time_left
	water_progress_bar.value = water_amount
	
	# start growing it
	if water_amount >= water_needed and growth_timer.is_stopped(): # so it only runs timer once:
		growth_timer.start()
		growth_progress.show()
		water_progress.hide()


func _on_growth_timer_timeout():
	var new_tree = TREE.instantiate()
	new_tree.global_position = global_position
	game.add_child(new_tree)
	queue_free() # remove this after tree spawns in
