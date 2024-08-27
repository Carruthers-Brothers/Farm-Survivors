extends "res://Scripts/Upgrades/upgrades.gd"
class_name PlantCooldown

func _init():
	upgrade_name = "Plant Cooldown"
	description = "Decreases time it takes before you are able to plant again"

func apply_upgrade(player: Node):
	var cooldown = player.seed_cooldown.wait_time
	cooldown -= 1
	player.seed_cooldown.wait_time = clamp(cooldown, 1, 10)


func increase_level():
	pass # level isn't tracked for this one
