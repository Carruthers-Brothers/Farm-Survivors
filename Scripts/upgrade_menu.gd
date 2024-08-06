extends Control

@onready var upgrade_button_1 = $UpgradeButton1
@onready var upgrade_button_2 = $UpgradeButton2
@onready var upgrade_button_3 = $UpgradeButton3 # upgrade selection
@onready var player = get_tree().get_first_node_in_group("player")

# have a script with all upgrades, or currently available upgrades, then offer 3 randomly from that pool
# "apply_upgrade" function from an upgrade object? all of them inherit from upgrade. Tracks its current level, then each overwrites apply_upgrade

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_upgrade_button_1_pressed(): # apply upgrade to player, then hide upgrade screen
	# will take the upgrade object, then just apply_upgrade() to player
	hide() 
	get_tree().paused = false


func _on_upgrade_button_2_pressed():
	hide()
	get_tree().paused = false


func _on_upgrade_button_3_pressed():
	hide()
	get_tree().paused = false
