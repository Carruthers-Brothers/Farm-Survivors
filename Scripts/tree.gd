extends Node2D

@onready var range_area = $RangeArea
@onready var tree = $"."
@onready var marker_2d = $Marker2D
@onready var harvest_progress_bar = $HarvestProgress/HarvestProgressBar
@onready var harvest_progress = $HarvestProgress
@onready var player = get_tree().get_first_node_in_group("player")
#@onready var sprite_2d = $Sprite2D
@onready var apple_tree = $AppleTree
@onready var orange_tree = $OrangeTree
@onready var blue_tree = $BlueTree


const FULL_APPLE_FAST = preload("res://Assets/fullAppleFast.png")
const APPLE = preload("res://Scenes/apple.tscn")

var target
var harvest_amount = 0
var health = 100
var xp_amount # depends on rarity
var rarity = "Uncommon"

var xp_rarity = {
	"Common" : 20,
	"Uncommon" : 40,
	"Rare" : 60,
	"Epic" : 80,
	"Legendary" : 100
}

@onready var hurtbox = $Hurtbox
@onready var health_bar = $HealthBar


func _ready():
	var random_tree_graphic = randi_range(0,2)
	if random_tree_graphic == 0:
		apple_tree.show()
	elif random_tree_graphic == 1:
		orange_tree.show()
	else:
		blue_tree.show()

func _process(_delta):
	
	harvest_progress_bar.value = harvest_amount
	
	if harvest_amount > 0: # player has started harvesting the tree
		harvest_progress.show()
	
	if harvest_amount >= 100:
		# add xp to player based on tree rarity
		player.add_xp(xp_rarity[rarity])
		queue_free() # give experience to player, and remove

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var enemies_in_range = range_area.get_overlapping_areas()
	
	if enemies_in_range.size() > 0:
		target = enemies_in_range.front()
	else:
		target = null
		
	# take damage from enemies
	var enemy_areas = hurtbox.get_overlapping_areas()
	for area in enemy_areas:
		var enemy = area.get_parent()
		if enemy.enemy_type == "beaver":
			health -= enemy.damage_dealt * delta # if enemies deal different amounts of damage
			health_bar.value = health
			if health <= 0:
				queue_free()


func _on_timer_timeout():
	if target:
		shoot()


func shoot():
	var apple = APPLE.instantiate()
	apple.global_position = marker_2d.global_position # spawn apple projectile at top section of tree
	apple.target = target
	marker_2d.add_child(apple) # adding to actual scene
