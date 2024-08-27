extends Control

@onready var pause_menu = $"."

var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("pause"): # escape key pressed 
		if paused: # if already paused, unpause and hide pause menu
			if not Global.upgrade_pause: # don't unpause if paused by upgrade menu
				get_tree().paused = false
			pause_menu.hide()
		else: # if unpaused, pause and show pause menu
			get_tree().paused = true
			pause_menu.show()
		paused = !paused 

func _on_resume_pressed():
		if paused: 
			if not Global.upgrade_pause: # don't unpause if paused by upgrade menu
				get_tree().paused = false
			paused = !paused
			pause_menu.hide()


func _on_quit_pressed():
	get_tree().quit()
	
