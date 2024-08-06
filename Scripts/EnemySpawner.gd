extends Node2D

@onready var timer = $WaveTimer
@onready var player = $"../Player"

const BUNNY = preload("res://Scenes/Enemies/bunny.tscn")
const BEAVER = preload("res://Scenes/Enemies/beaver.tscn")
const HORNET = preload("res://Scenes/Enemies/hornet.tscn")
const ENEMY_WAVES = preload("res://Scripts/enemy_waves.json") # all wave data to spawn enemies for a run

const enemy_dict = { # convert from string to actual enemy scene resource
	"bunny" : BUNNY,
	"beaver" : BEAVER, 
	"hornet" : HORNET
}

var waves : Array[Wave] = [] 
var wave_index = 0
var path_2d

# Called when the node enters the scene tree for the first time.
func _ready():
	path_2d = player.get_node("Path2D/PathFollow2D")
	
	# create all the waves from JSON file containing wave information
	var file = FileAccess.open("res://Scripts/enemy_waves.json", FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())
	var data = json_object.get_data()
	var all_waves = data["waves"]
	var current_wave_index = 1
	
	for wave in all_waves: 
		var new_wave:Wave = Wave.new()
		var current_wave = wave[str(current_wave_index)]
		for chunk in current_wave: # chunks of wave_info
			var wave_info:Wave_Info = Wave_Info.new()
			wave_info.enemy = enemy_dict[chunk["enemy"]] # grab string of enemy type, then convert to actual resource
			wave_info.num = chunk["count"]
			new_wave.wave_chunks.append(wave_info) 
		waves.append(new_wave)
		current_wave_index += 1


func get_spawn_position():
	path_2d.progress_ratio = randf()
	return path_2d.global_position


func _on_wave_timer_timeout():
	if wave_index < waves.size():
		var wave = waves[wave_index]
		for wave_info in wave.wave_chunks:
			for i in range(wave_info.num):
				var enemy = wave_info.enemy.instantiate()
				enemy.global_position = get_spawn_position()
				var game = get_tree().get_first_node_in_group("game")
				game.add_child(enemy)
		wave_index += 1
		
	# need to set chunk timer amount to 5 / chunks. 

