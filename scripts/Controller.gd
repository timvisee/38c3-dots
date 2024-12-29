extends Node


var fullscreen = false;

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit();
	if event.is_action_pressed("fullscreen"):
		toggle_fullscreen()


func toggle_fullscreen():
	if !fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true;
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false;
