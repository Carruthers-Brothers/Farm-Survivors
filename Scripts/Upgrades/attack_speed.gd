extends "res://Scripts/Upgrades/upgrades.gd"
class_name AttackSpeed

func _init():
	upgrade_name = "Attack Speed"
	description = "Increases attack speed of weapons."

func apply_upgrade(player: Node):
	# pass in player node to apply upgrade
	# upgrade can scale differently based on level
	match(level):
		1:
			player.attack_speed += 2
		2: 
			player.attack_speed += 3
		3: 
			player.attack_speed += 4
		_: 
			player.attack_speed += 2


func increase_level():
	level += 1
