extends Resource
class_name Upgrade

var level = 0 # current level of the upgrade
var max_level = 3 # max level 3 for all upgrades
var upgrade_name = ""
var description = ""


func increase_level():
	level += 1

# attack speed, player speed, water collect speed, harvesting speed
# weapons are treated as upgrades with levels (number of projectiles, etc.)
