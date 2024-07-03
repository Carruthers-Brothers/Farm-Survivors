extends Node2D

@onready var range_area = $RangeArea
const APPLE = preload("res://Scenes/apple.tscn")
@onready var tree = $"."
@onready var marker_2d = $Marker2D
var target


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
