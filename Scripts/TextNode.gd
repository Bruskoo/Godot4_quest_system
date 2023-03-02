extends GraphNode

@onready var text_edit = $MarginContainer/VBoxContainer/HBoxContainer3/TextEdit
@onready var previos_size = text_edit.size


func change_color_request(color):
	self.get_theme_stylebox("frame").bg_color = color
	self.get_theme_stylebox("selected_frame").bg_color = color


func _on_expand_toggled(button_pressed):
	if button_pressed:
		text_edit.set_fit_content_height_enabled(true)
	else:
		text_edit.set_fit_content_height_enabled(false)
		text_edit.size = previos_size
		self.size = Vector2(400, 250)


func _on_close_request():
	GlobalServiceVariables.node_close_request(self)
	queue_free()
