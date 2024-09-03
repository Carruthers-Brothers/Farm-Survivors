extends "res://Scripts/projectile.gd"

@onready var game = get_tree().get_first_node_in_group("game")
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
const SEED = preload("res://Scenes/seed.tscn")

var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))

func _ready():
	distance_to_travel = randi_range(25, 100)

func get_direction():
	return direction
	
func self_destruct():
	sprite_2d.hide()
	animated_sprite_2d.show()
	animated_sprite_2d.play('default')
	# drops a pickup-able seed sometimes
	var num = randf_range(1,100)
	if num <= 10: # drop chance
		create_seed("Uncommon")

func create_seed(seed_type):
	var seed = SEED.instantiate()
	seed.global_position = global_position
	game.add_child(seed)
	seed.set_type(seed_type)


func _on_animated_sprite_2d_animation_finished():
	queue_free()
