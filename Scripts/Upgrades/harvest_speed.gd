extends "res://Scripts/Upgrades/upgrades.gd"
class_name HarvestSpeed

func _init():
	upgrade_name = "Harvesting Speed"
	description = "Increases rate of harvesting trees."

func apply_upgrade(player: Node):
	# pass in player node to apply upgrade
	# upgrade can scale differently based on level
	match(level):
		1:
			player.harvest_speed += 10
		2: 
			player.harvest_speed += 10
		3: 
			player.harvest_speed += 10
		_: 
			player.harvest_speed += 10


func increase_level():
	level += 1
