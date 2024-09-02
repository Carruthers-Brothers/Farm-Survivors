extends "res://Scripts/projectile.gd"

var target # enemy target that the apple will travel towards

func _ready():
	distance_to_travel = 500

func reach_destination():
	queue_free()

func get_direction():
	if is_instance_valid(target):
		if target != null: # sometimes will say that null is valid instance?
			return global_position.direction_to(target.global_position) 


