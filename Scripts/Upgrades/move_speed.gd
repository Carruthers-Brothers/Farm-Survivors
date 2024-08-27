extends "res://Scripts/Upgrades/upgrades.gd"
class_name MoveSpeed

func _init():
	upgrade_name = "Move Speed"
	description = "Increases move speed of player."

func apply_upgrade(player: Node):
	# pass in player node to apply upgrade
	# upgrade can scale differently based on level
	match(level):
		1:
			player.speed += 5
		2: 
			player.speed += 10
		3: 
			player.speed += 15
		_: 
			player.speed += 5


func increase_level():
	level += 1
