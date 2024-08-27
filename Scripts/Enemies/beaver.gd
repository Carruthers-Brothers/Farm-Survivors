extends "res://Scripts/Enemies/enemy.gd"

@onready var range_area = $RangeArea
@onready var visibility_on_screen_notifier = $VisibleOnScreenNotifier2D
# @onready var run_sprite = $RunSprite
@onready var eat_sprite = $EatSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 20
	damage_dealt = 20
	health = 30
	enemy_type = "beaver"

func _process(delta):
	# check if beaver is on tree
	if target != null:
		var distance = global_position.distance_to(target.global_position)
		if target.is_in_group("tree") and distance < 5:
			eat_sprite.show()
			animated_sprite_2d.hide()
		else:
			animated_sprite_2d.show()
			eat_sprite.hide()


func getTarget():
	var isOnScreen = visibility_on_screen_notifier.is_on_screen()
	var targets_in_range = range_area.get_overlapping_areas()
	
	if isOnScreen && targets_in_range.size() > 0:
		return targets_in_range.front().get_parent() # get parent of area node
	return player
