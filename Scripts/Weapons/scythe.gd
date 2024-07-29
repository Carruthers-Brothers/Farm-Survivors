extends Node2D

@onready var scythe = $"."
var rotation_speed = 4
var damage = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scythe.global_rotation += rotation_speed * delta


func _on_area_2d_area_entered(area):
	var enemy = area.get_parent()
	if enemy.has_method("take_damage"):
		enemy.take_damage(damage)
