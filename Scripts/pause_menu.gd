extends Control

var _is_paused: bool = false:
	set = set_paused
	
func _unhandled_input(event):
	if event.is_action_pressed("Menu") and not %Player.getIsInMenu() and not %Player.getIsInInventory():
		_is_paused = !_is_paused
		%Player.setIsInMenu(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("Menu") and not %Player.getIsInMenu() and %Player.getIsInInventory():
		%Player.inventoryControl()
		%Player.setIsInMenu(true)
		_is_paused = !_is_paused
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
func set_paused(value:bool) -> void:
	_is_paused = value
	# get_tree().paused = _is_paused # use this if we want game to actually pause when menu is open
	visible = _is_paused

func get_paused() -> bool:
	return _is_paused


func _on_resume_button_pressed():
	_is_paused = false
	%Player.setIsInMenu(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
