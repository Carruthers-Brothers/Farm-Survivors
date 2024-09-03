extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox
@onready var health_bar = $HealthBar
@onready var seed_cooldown = $SeedCooldown
@onready var scythe = $Scythe
@onready var game = get_tree().get_first_node_in_group("game")

const SpadeUpgrade = preload("res://Scripts/Weapons/spade_upgrade.gd")
const SEED = preload("res://Scenes/seed.tscn")
const SPROUT = preload("res://Scenes/sprout.tscn")

var previous_direction = "right" # save previous direction for idle animations after stop moving
var health = 100
var speed = 100
var plantable = true
var water_level = 0.0 # how much water is in the watering can
var total_xp = 0
var xp_modifier = 1.0
var level = 1 # have xp amounts needed for each level
var attack_speed = 4 
var water_speed = 50
var harvest_speed = 50

var direction 
var watering_target 
var harvesting_target

# seed inventory for the different types of seed rarities or seed types
var seeds = { 
	"Common" : 0,
	"Uncommon" : 0
}

signal player_death
signal level_up


func _physics_process(delta):
	
	# check if xp amount is enough to level up, then emit level up signal
	var xp_needed = 100 * level
	if total_xp >= xp_needed:
		level += 1
		emit_signal("level_up")
	
	# seed planting
	if Input.is_action_just_pressed("plant"):
		plant_seed()

	# movement and animations
	direction = Input.get_vector("left", "right", "up", "down") # Input map set for directions in Project->Project Settings->Input Map
	velocity = direction * speed
	
	# walking animations
	if direction.x < 0: 
		animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = true
		previous_direction = "left"
	elif direction.x > 0:
		animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = false
		previous_direction = "right"
	else: # if walking up or down, still play walk animation in direction you were facing before
		if previous_direction == "right":
			animated_sprite_2d.play("walk")
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.play("walk")
			animated_sprite_2d.flip_h = true
	
	if velocity.length() == 0: # not moving
		animated_sprite_2d.play("idle")
		
	move_and_slide() # moves character based on its velocity
	check_collisions(delta) # check all overlapping collisions for things like enemies, pick up items, watering, etc.


func plant_seed():
	
	# get selected amount from UI, then check count
	var ui = get_tree().get_first_node_in_group("ui")
	var selected = ui.selected 
	
	# later change for different seed types, and which one is selected to plant
	if plantable and seeds[selected] > 0:
		plantable = false
		seeds[selected] -= 1
		seed_cooldown.start() # seed planted, start cooldown before can plant again
		var new_sprout = SPROUT.instantiate()
		new_sprout.global_position = global_position # plant where player is
		new_sprout.rarity = selected # selected is rarity / type
		game.add_child(new_sprout) # add seed to Game scene


func _on_seed_cooldown_timeout():
	plantable = true # able to plant another seed
	

func add_xp(xp_amount):
	total_xp += xp_amount * xp_modifier


func check_collisions(delta):
	
	harvesting_target = null
	watering_target = null # make sure target is valid every frame
	var areas = hurtbox.get_overlapping_areas()
	
	for area in areas: 

		find_best_target(area) # for watering and harvesting
		
		if area.collision_layer == 2: # enemy layer (taking damage)
			var enemy = area.get_parent()
			health -= enemy.damage_dealt * delta # if enemies deal different amounts of damage
			health_bar.value = health
			if health <= 0:
				emit_signal("player_death") 
		elif area.collision_layer == 4: # seed layer (picking up seeds)
			var seed = area.get_parent()
			seeds[seed.seed_type] += 1
			seed.queue_free()
		elif area.collision_layer == 8: # pools of water layer (filling watering can)
			if Input.is_action_pressed("water"):
				var level_change = delta * water_speed
				water_level += level_change
				if water_level > 100: # change to fill up over time while pressing
					water_level = 100
				var pond = area.get_owner() # instead of area.get_parent().get_parent()
				if pond.has_method("reduce_water"): # reduce water level
					pond.reduce_water(level_change)
					
	# water only one thing at a time, and only if it isn't full already
	if Input.is_action_pressed("water") and watering_target != null:
		if water_level > 0: # player has water to give the plant
			var plant = watering_target
			var level_change = delta * water_speed 
			if plant.water_amount <= plant.water_needed: # don't water if it doesn't need it
				plant.water_amount += level_change
				water_level -= level_change
				if water_level < 0:
					water_level = 0
	# harvest one thing at a time
	if Input.is_action_pressed("harvest") and harvesting_target != null:
		var harvest = delta * harvest_speed
		harvesting_target.harvest_amount += harvest


func find_best_target(test_area):
	# find the best target (if any) when the action "water" is pressed
	var test_target = test_area.get_parent()
	if test_area.collision_layer == 16: # plants layer (to water)
		if watering_target == null:
			watering_target = test_target
		else:
			# find one that needs water, and is closest
			if test_target.water_amount <= test_target.water_needed: # plant actually needs to be watered, not growing
				var current_distance = global_position.distance_to(watering_target.global_position)
				var test_distance = global_position.distance_to(test_target.global_position)
				if test_distance < current_distance: # closest physical collision
					watering_target = test_target
	elif test_area.collision_layer == 32: # harvest layer
		if harvesting_target == null:
			harvesting_target = test_target
		else:
			# find one that is closest
			var current_distance = global_position.distance_to(harvesting_target.global_position)
			var test_distance = global_position.distance_to(test_target.global_position)
			if test_distance < current_distance: 
				harvesting_target = test_target
