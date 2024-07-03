extends Area2D

var target # enemy target that the apple will travel towards
var speed = 300
var damage = 5
var distance_traveled = 0 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	position += direction * speed * delta # not a character body, so doesn't have move_and_slide(), need delta
	
	distance_traveled += speed * delta
	if distance_traveled > 500: # despawn if it has gone off screen
		queue_free()


func _on_area_entered(area):
	var enemy = area.get_parent()
	enemy.take_damage(damage)
	# alternate method
	#if enemy.has_method("take_damage"):
		#enemy.take_damage(damage)
	queue_free()
