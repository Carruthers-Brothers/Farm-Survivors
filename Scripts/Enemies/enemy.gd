extends CharacterBody2D

var speed
var damage_dealt
var health
var enemy_type
var target

@onready var game = get_tree().get_first_node_in_group("game")
@onready var player = get_node("/root/Game/Player")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox

const SEED = preload("res://Scenes/seed.tscn")

func _physics_process(_delta):
	target = getTarget()
	var direction = global_position.direction_to(target.global_position)
	velocity = speed * direction
	
	if direction.x > 0: # change to be position relative to target
		animated_sprite_2d.flip_h = false # traveling right, don't flip
	else:
		animated_sprite_2d.flip_h = true # traveling left, flip
	
	if global_position.distance_to(target.global_position) > 0.5: # so it doesn't flip back and forth rapidly on target
		move_and_slide() # move and slide accounts for delta time
	

func take_damage(damage):
	health -= damage
	if health <= 0:
		# drops a pickup-able seed sometimes
		var num = randf_range(1,100)
		if num <= 10: # drop chance
			create_seed("Uncommon")
		elif num <= 15:
			create_seed("Common")
		queue_free()
		
func getTarget():
	return player


func create_seed(seed_type):
	var seed = SEED.instantiate()
	seed.global_position = global_position
	game.add_child(seed)
	seed.set_type(seed_type)
