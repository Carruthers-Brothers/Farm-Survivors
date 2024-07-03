extends Control

@onready var death_menu = $"."


func _on_restart_pressed():
	get_tree().paused = false # unfreeze everything before reloading
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()
