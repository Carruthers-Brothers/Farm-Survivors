extends Area2D

var speed = 300
var damage = 5
var distance_to_travel
var distance_traveled = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if distance_traveled > distance_to_travel:
		reach_destination()
		return
	
	var direction = get_direction()
	
	if direction != null:
		position += direction * speed * delta # not a character body, so doesn't have move_and_slide(), need delta
	else:
		queue_free()
		
	distance_traveled += speed * delta


func _on_area_entered(area):
	var enemy = area.get_parent()
	if enemy.has_method("take_damage"):
		enemy.call_deferred("take_damage", damage)
		self_destruct()

func reach_destination():
	return

func get_direction():
	return null

func self_destruct():
	queue_free()
