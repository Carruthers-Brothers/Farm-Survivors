extends "res://Scripts/Weapons/weapon.gd"

@onready var player = get_tree().get_first_node_in_group("player")
@onready var game = get_tree().get_first_node_in_group("game")

const SPADE = preload("res://Scenes/Weapons/spade.tscn")

var shoot_timer
var upgrade_name = "Spade"
var description = "Weapon that shoots out in the direction the player is moving"


func _ready(): # ready instead of init compared to Resource upgrades
	shoot_timer = Timer.new()
	shoot_timer.autostart = true
	shoot_timer.wait_time = 3.0
	shoot_timer.timeout.connect(on_shoot_timer_timeout) # connect timer to this manually
	add_child(shoot_timer)


func apply_upgrade(player): # or base this on attack speed? 
	if level == 1:
		player.add_child(self)
	elif level == 2:
		shoot_timer.wait_time -= 1
	else: 
		shoot_timer.wait_time -= 0.5


func on_shoot_timer_timeout():
	var new_spade = SPADE.instantiate()
	new_spade.global_position = player.global_position
	var player_velocity = player.velocity
	new_spade.direction = player.direction
	if player.direction == Vector2(0, 0):
		# towards previous direction
		var prev = player.previous_direction
		match prev:
			"right":
				new_spade.direction = Vector2(1, 0)
			"left":
				new_spade.direction = Vector2(-1, 0)
			"up":
				new_spade.direction = Vector2(0, -1)
			"down":
				new_spade.direction = Vector2(0, 1)
	new_spade.rotation_degrees = rad_to_deg(new_spade.direction.angle()) - 90
	game.add_child(new_spade)
