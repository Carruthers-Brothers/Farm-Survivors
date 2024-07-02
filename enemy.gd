extends CharacterBody2D


var speed = 50 # half of player speed
var damage = 20
var health = 5

@onready var player = get_node("/root/Game/Player")
@onready var sprite_2d = $Sprite2D
@onready var hitbox = $Hitbox


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = speed * direction
	
	if velocity.x > 0: # change to be position relative to player
		sprite_2d.flip_h = true # traveling right, flip sprite to face right
	else:
		sprite_2d.flip_h = false # traveling left, flip back to default facing left
	
	move_and_slide() # move and slide accounts for delta time
	
	

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
