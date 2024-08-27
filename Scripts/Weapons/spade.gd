extends Marker2D

@onready var on_screen = $OnScreen

var damage = 20
var speed = 200
var direction 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_area_2d_area_entered(area):
	var enemy = area.get_parent() # damage enemies
	if enemy.has_method("take_damage"):
		enemy.call_deferred("take_damage", damage)


func _on_on_screen_screen_exited():
	queue_free()
