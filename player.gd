extends CharacterBody2D

var speed = 100

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox

var previous_direction = "down" # save previous direction for idle animations after stop moving
var health = 100

func _physics_process(delta):

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
	
	move_and_slide()
	
	# taking damage
	var damage = 50
	var enemy_collisions = hurtbox.get_overlapping_areas()
	var num_enemies = enemy_collisions.size()
	if  num_enemies > 0:
		health -= damage * num_enemies * delta
		if health <= 0:
			print("game over")
			get_tree().quit() # exit on death for now
	
