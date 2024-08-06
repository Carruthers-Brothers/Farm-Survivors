extends Control

@onready var common_count = $SeedContainer/CommonButton/CommonCount
@onready var uncommon_count = $SeedContainer/UncommonButton/UncommonCount
@onready var rare_count = $SeedContainer/RareButton/RareCount
@onready var epic_count = $SeedContainer/EpicButton/EpicCount
@onready var legendary_count = $SeedContainer/LegendaryButton/LegendaryCount
@onready var seed_count = $SeedContainer/SeedCount
@onready var water_progress = $WaterProgress
@onready var seed_progress = $SeedProgress
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
	level_progress.value = player.total_xp % 100
	
	# all seed inventory ui updates
	var seeds_dict = player.seeds
	common_count.text = str(seeds_dict["Common"])
	uncommon_count.text = str(seeds_dict["Uncommon"])
	rare_count.text = str(seeds_dict["Rare"])
	epic_count.text = str(seeds_dict["Epic"])
	legendary_count.text = str(seeds_dict["Legendary"])
	
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

func _on_rare_button_pressed():
	selected = "Rare"

func _on_epic_button_pressed():
	selected = "Epic"

func _on_legendary_button_pressed():
	selected = "Legendary"
