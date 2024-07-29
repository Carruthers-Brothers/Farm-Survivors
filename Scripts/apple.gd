extends Area2D

var target # enemy target that the apple will travel towards
var speed = 300
var damage = 5
var distance_traveled = 0 
var direction

func _ready():
	if is_instance_valid(target):
		direction = global_position.direction_to(target.global_position)
	# could just set position at beginning, and go same direction, just faster

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# error when enemy dies and second apple projectile floats mid air without target
	
	if is_instance_valid(target):
		direction = global_position.direction_to(target.global_position) 
	
	# target null, or thinks it has reached target location and spams that area
	# or it just isn't as fast as the enemy, because it still follows them but doesn't touch

	position += direction * speed * delta # not a character body, so doesn't have move_and_slide(), need delta
	
	distance_traveled += speed * delta
	if distance_traveled > 500: # despawn if it has gone off screen
		queue_free()


func _on_area_entered(area):
	var enemy = area.get_parent()
	if enemy.has_method("take_damage"):
		enemy.take_damage(damage)
		queue_free()
