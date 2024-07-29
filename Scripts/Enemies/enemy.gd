extends CharacterBody2D

var speed
var damage_dealt
var health

@onready var player = get_node("/root/Game/Player")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = speed * direction
	
	if direction.x > 0: # change to be position relative to player
		animated_sprite_2d.flip_h = false # traveling right, don't flip
	else:
		animated_sprite_2d.flip_h = true # traveling left, flip
	
	if global_position.distance_to(player.global_position) > 0.5: # so it doesn't flip back and forth rapidly on player
		move_and_slide() # move and slide accounts for delta time
	
	

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()

# all enemies can take damage, move towards player, etc. Each one has different animations, speed, health, and damage dealt
# so inherited part sets those values for each one. Or just make it a class and set the values for each enemy type? 
# should the graphics be singleton for the monsters? probably. or the animatedsprite2d is the same?
