extends Control

@onready var common_count = $SeedContainer/TextureRect/CommonButton/CommonCount
@onready var uncommon_count = $SeedContainer/TextureRect/UncommonButton/UncommonCount
@onready var water_progress = $UpperRightControls/WaterProgress
@onready var seed_progress = $UpperRightControls/SeedProgress
@onready var time = $Time
@onready var level_text = $LevelText
@onready var level_progress = $LevelProgress

var player

var selected = "Common" # whatever type of seed player currently has selected to plant
var time_elapsed = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# progress bar updates
	seed_progress.value = 10 - player.seed_cooldown.time_left 
	water_progress.value = player.water_level
	level_text.text = "Level " + str(player.level)
	level_progress.value = int(player.total_xp) % 100
	
	# all seed inventory ui updates
	var seeds_dict = player.seeds
	common_count.text = str(seeds_dict["Common"])
	uncommon_count.text = str(seeds_dict["Uncommon"])
	
	# time formatting to display
	time_elapsed += delta
	var minutes = int(time_elapsed) / 60
	var seconds = int(time_elapsed) % 60
	if seconds < 10:
		time.text = "0" + str(minutes) + ":0" + str(seconds) 
	else:
		time.text = "0" + str(minutes) + ":" + str(seconds)


func _on_common_button_pressed():
	selected = "Common"

func _on_uncommon_button_pressed():
	selected = "Uncommon"
