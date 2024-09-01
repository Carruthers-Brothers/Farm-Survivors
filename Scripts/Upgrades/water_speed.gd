extends "res://Scripts/Upgrades/upgrades.gd"
class_name WaterSpeed

func _init():
	upgrade_name = "Watering Speed"
	description = "Increases rate of filling up watering can and watering plants."

func apply_upgrade(player: Node):
	# pass in player node to apply upgrade
	# upgrade can scale differently based on level
	match(level):
		1:
			player.water_speed += 10
		2: 
			player.water_speed += 20
		3: 
			player.water_speed += 30
		_: 
			player.water_speed += 10


func increase_level():
	level += 1
