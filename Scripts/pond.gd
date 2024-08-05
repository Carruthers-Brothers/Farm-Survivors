extends Node2D

@onready var pond_1 = $Pond1
@onready var pond_2 = $Pond2
@onready var pond_3 = $Pond3
@onready var pond_4 = $Pond4

var water_supply = 300

func _ready():
	
	var rand_shape = randi_range(0,3) # get random pond graphic / shape for variety 
	if rand_shape == 0:
		pond_1.show()
		pond_1.process_mode = Node.PROCESS_MODE_INHERIT # disabling others so that collisions don't interact
	elif rand_shape == 1:
		pond_2.show()
		pond_2.process_mode = Node.PROCESS_MODE_INHERIT
	elif rand_shape == 2:
		pond_3.show()
		pond_3.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		pond_4.show()
		pond_4.process_mode = Node.PROCESS_MODE_INHERIT
	water_supply = randi_range(100, 300)
	var scale_coord = water_supply / 300.0
	scale = Vector2(scale_coord, scale_coord)
	

func reduce_water(amount): # when player detects collision with this pond
	water_supply -= amount
	if water_supply < 0:
		queue_free() # water supply drained. Will need checks to not deplete when watering can is full
