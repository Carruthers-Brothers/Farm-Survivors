extends Node2D

@onready var death_menu = $CanvasLayer/DeathMenu
@onready var main_ui = $CanvasLayer/MainUI
@onready var seed_progress = $CanvasLayer/MainUI/TextureProgressBar
@onready var seed_cooldown = $Player/SeedCooldown
@onready var time_label = $CanvasLayer/MainUI/Time

var time_elapsed = 0.0


func _process(delta):
	seed_progress.value = 10 - seed_cooldown.time_left 
	time_elapsed += delta
	# formatted timer text
	var minutes = int(time_elapsed) / 60
	var seconds = int(time_elapsed) % 60
	if seconds < 10:
		time_label.text = "0" + str(minutes) + ":0" + str(seconds) 
	else:
		time_label.text = "0" + str(minutes) + ":" + str(seconds)


func _on_player_player_death():
	death_menu.show()
	get_tree().paused = true
