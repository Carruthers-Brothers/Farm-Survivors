extends Node2D

@onready var game = get_tree().get_first_node_in_group("game")
@onready var growth_timer = $GrowthTimer
@onready var texture_progress_bar = $Control/TextureProgressBar


const TREE = preload("res://Scenes/tree.tscn")


func _ready():
	growth_timer.start()
	

func _process(delta):
	texture_progress_bar.value = 20 - growth_timer.time_left

func _on_growth_timer_timeout():
	# grow tree after 20 seconds
	var new_tree = TREE.instantiate()
	new_tree.global_position = global_position
	game.add_child(new_tree)
	queue_free() # remove seed after tree spawns in

