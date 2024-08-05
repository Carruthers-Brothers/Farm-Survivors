extends Node2D

@onready var range_area = $RangeArea
const APPLE = preload("res://Scenes/apple.tscn")
@onready var tree = $"."
@onready var marker_2d = $Marker2D
@onready var hurtbox = $Hurtbox
@onready var health_bar = $HealthBar

var target
var health = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var enemies_in_range = range_area.get_overlapping_areas()
	if enemies_in_range.size() > 0:
		target = enemies_in_range.front()
	else:
		target = null
		
		# take damage from enemies
	var enemy_areas = hurtbox.get_overlapping_areas()
	for area in enemy_areas:
		var enemy = area.get_parent()
		health -= enemy.damage_dealt * delta # if enemies deal different amounts of damage
		health_bar.value = health
		if health <= 0:
			queue_free()


func _on_timer_timeout():
	if target:
		shoot()


func shoot():
	var apple = APPLE.instantiate()
	apple.global_position = marker_2d.global_position # spawn apple projectile at top section of tree
	apple.target = target
	marker_2d.add_child(apple) # adding to actual scene
