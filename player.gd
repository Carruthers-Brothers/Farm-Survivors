extends CharacterBody2D

const SPEED = 100
@onready var animated_sprite_2d = $AnimatedSprite2D
var previous_direction = "down" # save previous direction for idle animations after stop moving

func _physics_process(delta):

	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	
	match direction: # also check if something is already being held down, and only do the first one
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
	
	if velocity.length() == 0: # player is not moving
		match previous_direction:
			"left":
				animated_sprite_2d.play("idle_left")
			"right":
				animated_sprite_2d.play("idle_right")
			"up":
				animated_sprite_2d.play("idle_up")
			"down":
				animated_sprite_2d.play("idle_down")
	
	move_and_slide()
