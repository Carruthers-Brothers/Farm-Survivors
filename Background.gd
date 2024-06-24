extends TileMap

func _ready():
	for i in range(-100, 100): # initial setup with some decent distance
		for j in range(-100, 100):
			var random_x = randi_range(0,5)
			var random_y = randi_range(5,6)
			set_cell(0, Vector2i(i, j), 1, Vector2i(random_x, random_y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# figure out how to optimize tile generation when you get close, and potentially hiding graphics as you get farther
	
