extends "res://Scripts/projectile.gd"

func _ready():
	distance_to_travel = randi_range(25, 100)
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))

