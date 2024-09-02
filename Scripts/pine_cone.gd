extends "res://Scripts/projectile.gd"

var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))

func _ready():
	distance_to_travel = randi_range(25, 100)

func get_direction():
	return direction


