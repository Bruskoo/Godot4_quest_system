extends Control


func _ready():
	pass


func _on_graph_edit_gui_input(_event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var node_create_popup = load("res://Windows/NodeCreatePopup.tscn")
		node_create_popup = node_create_popup.instantiate()
		add_child(node_create_popup)
		node_create_popup.set_position(get_local_mouse_position())
