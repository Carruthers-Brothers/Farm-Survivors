extends Node2D

@onready var range_area = $RangeArea
@onready var tree = $"."
@onready var marker_2d = $Marker2D
@onready var harvest_progress_bar = $HarvestProgress/HarvestProgressBar
@onready var harvest_progress = $HarvestProgress

const APPLE = preload("res://Scenes/apple.tscn")

var target
var harvest_amount = 0


func _process(_delta):
	
	harvest_progress_bar.value = harvest_amount
	
	if harvest_amount > 0: # player has started harvesting the tree
		harvest_progress.show()
	
	if harvest_amount >= 100:
		# give player experience / power up
		queue_free() # give experience to player, and remove

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	var enemies_in_range = range_area.get_overlapping_areas()
	
	if enemies_in_range.size() > 0:
		target = enemies_in_range.front()
	else:
		target = null
		


func _on_timer_timeout():
	if target:
		shoot()


func shoot():
	var apple = APPLE.instantiate()
	apple.global_position = marker_2d.global_position # spawn apple projectile at top section of tree
	apple.target = target
	marker_2d.add_child(apple) # adding to actual scene
