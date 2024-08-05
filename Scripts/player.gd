extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox
@onready var health_bar = $HealthBar
@onready var seed_cooldown = $SeedCooldown
@onready var game = get_tree().get_first_node_in_group("game")

const SEED = preload("res://Scenes/seed.tscn")
const SPROUT = preload("res://Scenes/sprout.tscn")

var previous_direction = "right" # save previous direction for idle animations after stop moving
var health = 100
var speed = 100
var plantable = true
var water_level = 0.0 # how much water is in the watering can

# seed inventory for the different types of seed rarities or seed types
var seeds = { 
	"Common" : 0,
	"Uncommon" : 0, 
	"Rare" : 0,
	"Epic" : 0,
	"Legendary" : 0
}

signal player_death


func _physics_process(delta):

	# seed planting
	if Input.is_action_just_pressed("plant"):
		plant_seed()

	# movement and animations
	var direction = Input.get_vector("left", "right", "up", "down") # Input map set for directions in Project->Project Settings->Input Map
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
		game.add_child(new_sprout) # add seed to Game scene


func _on_seed_cooldown_timeout():
	plantable = true # able to plant another seed
	

func check_collisions(delta):
	
	var areas = hurtbox.get_overlapping_areas()
	for area in areas: 
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
				var level_change = delta * 50
				water_level += level_change
				if water_level > 100: # change to fill up over time while pressing
					water_level = 100
				var pond = area.get_owner() # instead of area.get_parent().get_parent()
				if pond.has_method("reduce_water"): # reduce water level
					pond.reduce_water(level_change)
		elif area.collision_layer == 16: # plant layer (watering plants)
			if Input.is_action_pressed("water"):
				if water_level > 0:
					var plant = area.get_parent()
					var level_change = 50 * delta
					plant.water_amount += level_change
					water_level -= level_change
					if water_level < 0:
						water_level = 0
		elif area.collision_layer == 32: # tree layer (harvesting trees)
			if Input.is_action_pressed("harvest"):
				var tree = area.get_parent()
				var harvest = 50 * delta
				tree.harvest_amount += harvest
