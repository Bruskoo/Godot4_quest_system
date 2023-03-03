extends Control

@onready var graph_edit = $GraphEdit


func _on_clear_pressed():
	graph_edit.clear_connections()
	for node in graph_edit.get_tree().get_nodes_in_group("graph_nodes"):
		node.queue_free()


func _on_settings_pressed():
	var preferences_window = load("res://Windows/Settings.tscn")
	preferences_window = preferences_window.instantiate()
	add_child(preferences_window)
