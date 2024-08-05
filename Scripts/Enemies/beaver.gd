extends "res://Scripts/Enemies/enemy.gd"
@onready var range_area = $RangeArea
@onready var visibility_on_screen_notifier = $VisibleOnScreenNotifier2D
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 50
	damage_dealt = 20
	health = 30
	
func getTarget():
	var isOnScreen = visibility_on_screen_notifier.is_on_screen()
	var targets_in_range = range_area.get_overlapping_areas()
	
	if isOnScreen && targets_in_range.size() > 0:
		return targets_in_range.front()
	return player
