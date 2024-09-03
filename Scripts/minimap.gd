extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var camera = $SubViewportContainer/SubViewport/Camera2D
@onready var sub_viewport = $SubViewportContainer/SubViewport
@onready var player_marker = $SubViewportContainer/SubViewport/PlayerMarker

const SAPLING = preload("res://Assets/sapling.png")
const SMALL_TREE = preload("res://Assets/small_tree.png")

const FULL_APPLE_FAST = preload("res://Assets/fullAppleFast.png")
const FULL_GREEN_FAST_1 = preload("res://Assets/fullGreenFast1.png")

var tree_sprites = {
	"Common" : FULL_APPLE_FAST,
	"Uncommon" : FULL_GREEN_FAST_1,
}

var all_sprites = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.position = player.position * 0.5 # since sprite size of map is scaled down by 1/2, position is 1/2 to accurately show where we are
	player_marker.position = player.position * 0.5



func add_sprite(plant):
	var new_sprite = Sprite2D.new()
	if plant.name == "Tree":
		new_sprite.texture = tree_sprites[plant.rarity]
		new_sprite.scale = Vector2(.01, .01)
	elif plant.name == "SmallTree":
		new_sprite.texture = SMALL_TREE
		new_sprite.scale = Vector2(.1, .1)
	else: # name == "Sprout"
		new_sprite.texture = SAPLING
		new_sprite.scale = Vector2(.1, .1)
	# new_sprite.scale = Vector2(.01, .01) # might have to do different scales for each one
	new_sprite.position = plant.position * 0.5
	if sub_viewport != null:
		sub_viewport.add_child(new_sprite)
		all_sprites.append(new_sprite)


func remove_sprite(plant): # find the one with the same global position?
	var index = 0
	for sprite in all_sprites:
		var adjusted_plant_position = plant.position * 0.5
		if sprite.position == adjusted_plant_position: # just remove based on the position
			all_sprites.remove_at(index)
			sprite.queue_free()
		index += 1
