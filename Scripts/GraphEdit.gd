extends GraphEdit

var service_globals = GlobalServiceVariables
var mouse_pressed = false


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_pressed = true
		else:
			mouse_pressed = false


func _ready():
	service_globals.connect("NODE_CLOSE_REQUEST", _on_node_close_request)
	service_globals.connect("NODE_CREATE_REQUEST", _on_node_create_request)


func spawn_node_on_cursor(node):
	var localposition = get_local_mouse_position()
	var scroll_ofset = get_scroll_ofs()
	node.position_offset = (scroll_ofset + localposition) / Vector2(get_zoom(), get_zoom())


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node, from_port, to_node, to_port)


func _on_node_create_request(node_type):
	match node_type:
		"text_node":
			var main_node = load("res://Nodes/TextNode.tscn")
			main_node = main_node.instantiate()
			add_child(main_node)
			spawn_node_on_cursor(main_node)
		"option_node":
			var option_node = load("res://Nodes/OptionNode.tscn")
			option_node = option_node.instantiate()
			add_child(option_node)
			spawn_node_on_cursor(option_node)


func _on_node_close_request(node):
	var node_connections = get_connection_list()
	var instance_name = node.get_name()
	for n in node_connections:	
		print(n)
		if instance_name == n["from"]:
#			print("disconecting ", instance_name, "from ", n["from"])
			disconnect_node(instance_name, 0, n["to"], 0)
		if instance_name == n["to"]:
#			print("disconecting ", n["to"], "from ", instance_name)
			disconnect_node(n["from"], 0, instance_name, 0)
