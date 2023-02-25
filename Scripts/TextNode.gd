extends GraphNode

@onready var text_edit = $MarginContainer/VBoxContainer/HBoxContainer3/TextEdit
@onready var previos_size = text_edit.size


func _ready():
	pass


func _on_expand_toggled(button_pressed):
	if button_pressed:
		text_edit.set_fit_content_height_enabled(true)
	else:
		text_edit.set_fit_content_height_enabled(false)
		text_edit.size = previos_size
		self.size = Vector2(400, 250)


func _on_text_edit_mouse_entered():
	if text_edit.scroll_fit_content_height == false:
		GlobalServiceVariables.text_edit_mouse_entered()


func _on_text_edit_mouse_exited():
	GlobalServiceVariables.text_edit_mouse_exited()


func _on_close_request():
	queue_free()
