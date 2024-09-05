extends Node2D

@onready var game = get_tree().get_first_node_in_group("game")
@onready var growth_timer = $GrowthTimer
@onready var growth_progress = $GrowthProgress
@onready var growth_progress_bar = $GrowthProgress/GrowthProgressBar
@onready var water_progress = $WaterProgress
@onready var water_progress_bar = $WaterProgress/WaterProgressBar
@onready var sprite_2d = $Sprite2D
@onready var minimap = get_tree().get_first_node_in_group("minimap")

var water_needed = 25
var water_amount = 0.0
var time = 5
var rarity
var plant_type

const SMALL_TREE = preload("res://Scenes/small_tree.tscn")


func _ready():
	plant_type = "Sprout"
	minimap.add_sprite(self)


func _process(_delta):
	
	growth_progress_bar.value = time - growth_timer.time_left
	water_progress_bar.value = water_amount
	
	# start growing it
	if water_amount >= water_needed and growth_timer.is_stopped(): # so it only runs timer once
		growth_timer.start()
		growth_progress.show()
		water_progress.hide()
	
	

func _on_growth_timer_timeout():
	var small_tree = SMALL_TREE.instantiate()
	small_tree.global_position = global_position
	small_tree.rarity = rarity
	minimap.remove_sprite(self)
	game.add_child(small_tree)
	queue_free() # remove this after tree spawns in
