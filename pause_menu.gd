extends Control

@onready var pause_menu = $"."

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if not paused:
			get_tree().paused = false
			pause_menu.hide()
		else:
			get_tree().paused = true
			pause_menu.show()
			

func _on_resume_pressed():
		if paused:
			pause_menu.hide()
			get_tree().paused = false
			paused = !paused


func _on_quit_pressed():
	get_tree().quit()
