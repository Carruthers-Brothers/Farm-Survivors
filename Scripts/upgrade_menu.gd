extends Control

@onready var upgrade_button_1 = $VBoxContainer/HBoxContainer/TextureButton1
@onready var upgrade_button_2 = $VBoxContainer/HBoxContainer2/TextureButton2
@onready var upgrade_button_3 = $VBoxContainer/HBoxContainer3/TextureButton3 # upgrade selection
@onready var upgrade_title_1 = $VBoxContainer/HBoxContainer/TextureButton1/UpgradeTitle1
@onready var upgrade_description_1 = $VBoxContainer/HBoxContainer/TextureButton1/UpgradeDescription1
@onready var upgrade_title_2 = $VBoxContainer/HBoxContainer2/TextureButton2/UpgradeTitle2
@onready var upgrade_description_2 = $VBoxContainer/HBoxContainer2/TextureButton2/UpgradeDescription2
@onready var upgrade_title_3 = $VBoxContainer/HBoxContainer3/TextureButton3/UpgradeTitle3
@onready var upgrade_description_3 = $VBoxContainer/HBoxContainer3/TextureButton3/UpgradeDescription3
@onready var player = get_tree().get_first_node_in_group("player")
@onready var upgrade_menu = { 
	0 : [upgrade_title_1, upgrade_description_1, upgrade_button_1],
	1 : [upgrade_title_2, upgrade_description_2, upgrade_button_2],
	2 : [upgrade_title_3, upgrade_description_3, upgrade_button_3]
}
@onready var plant_cooldown = PlantCooldown.new()

const SpadeUpgrade = preload("res://Scripts/Weapons/spade_upgrade.gd")

var all_upgrades = {}
var upgrade_options = []


# upgrades: attack speed, move speed, harvest speed, watering / collecting speed, xp gain
# weapons: scythe, spade, and do 3 others
# max out at certain point for these levels of things
func _ready():
	# initialize all upgrades to level 1, and store them. 
	var attack_speed = AttackSpeed.new()
	all_upgrades["attack_speed"] = attack_speed # add to upgrade dictionary
	var move_speed = MoveSpeed.new()
	all_upgrades["move_speed"] = move_speed
	var harvest_speed = HarvestSpeed.new()
	all_upgrades["harvest_speed"] = harvest_speed
	var water_speed = WaterSpeed.new()
	all_upgrades["water_speed"] = water_speed
	var xp_gain = XPGain.new()
	all_upgrades["xp_gain"] = xp_gain
	var spade_upgrade = SpadeUpgrade.new()
	all_upgrades["spade"] = spade_upgrade
	var scythe = player.scythe # player starts with
	all_upgrades["scythe"] = scythe


func randomize_upgrades():
	
	var upgrade_size = all_upgrades.size()
	var upgrade_num = clamp(upgrade_size, 0, 3)
	if upgrade_num == 0:
		# show a default reward when no more upgrades
		upgrade_options.append(plant_cooldown)
		upgrade_menu[0][0].text = plant_cooldown.upgrade_name # Set title / name text
		upgrade_menu[0][1].text = plant_cooldown.description # Set description text
		upgrade_menu[1][2].hide()
		upgrade_menu[2][2].hide()
	else:
		for i in range(3): # want at most 3 upgrades, but less is fine
			if i < upgrade_num:
				# select three random upgrades to show, and set UI elements to them
				var upgrade_choice = all_upgrades.keys().pick_random()
				var upgrade = all_upgrades[upgrade_choice] # remove / transfer over to upgrade_options so you don't pick one twice
				upgrade_menu[i][0].text = upgrade.upgrade_name + " Lvl. " + str(upgrade.level + 1) # Set title / name text
				print("upgrade menu says ", upgrade_menu[i][0].text)
				upgrade_menu[i][1].text = upgrade.description # Set description text
				upgrade_menu[i][2].show()
				upgrade_options.append(upgrade) # gets random key from all keys in dict, then grabs upgrade
				all_upgrades.erase(upgrade_choice) # remove so it doesn't repeat selection
			else:
				# hide other options if maxed out on upgrades
				upgrade_menu[i][2].hide()


# will take the upgrade object, then just apply_upgrade() to player
func upgrade_pressed(num):
	# apply upgrade
	var upgrade_choice = upgrade_options[num]
	upgrade_choice.increase_level()
	upgrade_choice.apply_upgrade(player)
	if upgrade_choice.level >= upgrade_choice.max_level:
		upgrade_options.remove_at(num) # remove this max level upgrade as an options
	
	# put all options back in dictionary
	for upgrade in upgrade_options:
		all_upgrades[upgrade.upgrade_name] = upgrade
	upgrade_options.clear() # clear options 
	
	Global.upgrade_pause = false
	
	hide()
	get_tree().paused = false


func _on_texture_button_1_pressed():
	upgrade_pressed(0)


func _on_texture_button_2_pressed():
	upgrade_pressed(1)


func _on_texture_button_3_pressed():
	upgrade_pressed(2)
