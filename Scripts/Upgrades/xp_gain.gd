extends "res://Scripts/Upgrades/upgrades.gd"
class_name XPGain

func _init():
	upgrade_name = "XP Gain"
	description = "Increases xp gain of player from harvesting trees."

func apply_upgrade(player: Node):
	# pass in player node to apply upgrade
	# upgrade can scale differently based on level
	match(level):
		1:
			player.xp_modifier += 0.1
		2: 
			player.xp_modifier += 0.2
		3: 
			player.xp_modifier += 0.2
		_: 
			player.xp_modifier += 0.1


func increase_level():
	level += 1
