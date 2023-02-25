extends GraphEdit

#@onready var graph_edit = $GraphEdit
var service_globals = GlobalServiceVariables
var mouse_pressed = false


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_pressed = true
		else:
			mouse_pressed = false


func _ready():
	service_globals.connect("TEXT_EDIT_MOUSE_ENTERED", _on_text_edit_mouse_entered)
	service_globals.connect("TEXT_EDIT_MOUSE_EXITED", _on_text_edit_mouse_exited)


func spawn_node_on_cursor(node):
	var localposition = get_local_mouse_position()
	var scroll_ofset = get_scroll_ofs()
	node.position_offset = (scroll_ofset + localposition) / Vector2(get_zoom(), get_zoom())


func _on_text_edit_mouse_entered():
	var current_zoom = zoom
	zoom_max = current_zoom
	zoom_min = current_zoom


func _on_text_edit_mouse_exited():
	zoom_max = 2.074
	zoom_min = 0.233


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node, from_port, to_node, to_port)


func _on_gui_input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and mouse_pressed == true:
		var main_node = load("res://Nodes/MainNode.tscn")
		main_node = main_node.instantiate()
		add_child(main_node)
		spawn_node_on_cursor(main_node)
		mouse_pressed = false
