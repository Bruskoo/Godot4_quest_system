extends Control


@onready var graph_edit = $GraphEdit

func _ready():
	pass


func _on_graph_edit_gui_input(_event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var node_create_popup = load("res://Windows/NodeCreatePopup.tscn")
		node_create_popup = node_create_popup.instantiate()
		add_child(node_create_popup)
		node_create_popup.set_position(get_local_mouse_position())


func _on_clear_pressed():
	graph_edit.clear_connections()
	for node in graph_edit.get_tree().get_nodes_in_group("graph_nodes"):
		node.queue_free()


func _on_settings_pressed():
	var preferences_window = load("res://Windows/Settings.tscn")
	preferences_window = preferences_window.instantiate()
	add_child(preferences_window)
