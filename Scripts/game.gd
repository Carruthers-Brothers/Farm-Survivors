extends Node2D

@onready var death_menu = $CanvasLayer/DeathMenu
@onready var seed_progress = $CanvasLayer/MainUI/TextureProgressBar
@onready var seed_cooldown = $Player/SeedCooldown

var seed = 0

func _process(delta):
	seed_progress.value = 10 - seed_cooldown.time_left 


func _on_player_player_death():
	death_menu.show()
	get_tree().paused = true
