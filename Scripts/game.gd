extends Node2D

@onready var death_menu = $CanvasLayer/DeathMenu
@onready var main_ui = $CanvasLayer/MainUI
@onready var seed_progress = $CanvasLayer/MainUI/TextureProgressBar
@onready var seed_cooldown = $Player/SeedCooldown
@onready var time_label = $CanvasLayer/MainUI/Time


var time_elapsed = 0.0

func _process(delta):
	seed_progress.value = 10 - seed_cooldown.time_left 
	if not get_tree().paused:
		time_elapsed += delta
		time_label.text = str(time_elapsed).pad_decimals(2) # change to have minutes / seconds format


func _on_player_player_death():
	death_menu.show()
	get_tree().paused = true
