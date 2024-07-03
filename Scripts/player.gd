extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox
@onready var health_bar = $HealthBar
@onready var seed_cooldown = $SeedCooldown
@onready var game = get_tree().get_first_node_in_group("game")

const SEED = preload("res://Scenes/seed.tscn")

var previous_direction = "down" # save previous direction for idle animations after stop moving
var health = 100
var speed = 100
var plantable = true

signal player_death

func _physics_process(delta):

	
	# seed planting
	if Input.is_action_just_pressed("plant"):
		plant_seed()


	# movement and animations
	var direction = Input.get_vector("left", "right", "up", "down") # Input map set for directions in Project->Project Settings->Input Map
	velocity = direction * speed
	
	match direction: # play walk animation in the direction we are traveling
		Vector2(-1, 0):
			animated_sprite_2d.play("walk_left")
			previous_direction = "left"
		Vector2(1, 0):
			animated_sprite_2d.play("walk_right")
			previous_direction = "right"
		Vector2(0, -1):
			animated_sprite_2d.play("walk_up")
			previous_direction = "up"
		Vector2(0, 1):
			animated_sprite_2d.play("walk_down")
			previous_direction = "down"
	
	if velocity.length() == 0: # if player is not moving
		match previous_direction: # find last direction we traveled in so we are idle in that direction
			"left":
				animated_sprite_2d.play("idle_left")
			"right":
				animated_sprite_2d.play("idle_right")
			"up":
				animated_sprite_2d.play("idle_up")
			"down":
				animated_sprite_2d.play("idle_down")
	
	move_and_slide() # moves character based on its velocity
	
	# take damage from enemies
	var enemy_areas = hurtbox.get_overlapping_areas()
	for area in enemy_areas: 
		var enemy = area.get_parent()
		health -= enemy.damage_dealt * delta # if enemies deal different amounts of damage
		health_bar.value = health
		if health <= 0:
			emit_signal("player_death") 


func plant_seed():
	if plantable:
		plantable = false
		seed_cooldown.start() # seed planted, start cooldown before can plant again
		var new_seed = SEED.instantiate()
		new_seed.global_position = global_position # plant where player is
		game.add_child(new_seed) # add seed to Game scene


func _on_seed_cooldown_timeout():
	plantable = true # able to plant another seed
