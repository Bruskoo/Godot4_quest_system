extends GraphEdit

var mouse_pressed = false
var init_mouse_position
var selected_node_dict = {}


func _ready():
	GlobalServiceVariables.connect("NODE_CLOSE_REQUEST", _on_node_close_request)


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_pressed = true
		else:
			mouse_pressed = false

	if Input.is_action_just_pressed("create_text_node") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and mouse_pressed == true:
		var main_node = load("res://Nodes/TextNode.tscn")
		main_node = main_node.instantiate()
		add_child(main_node)
		main_node.add_to_group('graph_nodes')
		spawn_node_on_cursor(main_node)
		mouse_pressed = false
	
	if Input.is_action_just_pressed("create_line_shaping_node"):
		var line_connector = load("res://Nodes/LineShapingNode.tscn")
		line_connector = line_connector.instantiate()
		add_child(line_connector)
		line_connector.add_to_group('graph_nodes')
		spawn_node_on_cursor(line_connector)

	if Input.is_action_just_pressed("delete_key"):
		var node_connections = get_connection_list()
		for node in get_tree().get_nodes_in_group("graph_nodes"):
			if node.selected:
				var instance_name = node.get_name()
				for n in node_connections:	
					if instance_name == n["from"]:
						disconnect_node(instance_name, 0, n["to"], 0)
					if instance_name == n["to"]:
						disconnect_node(n["from"], 0, instance_name, 0)
					node.queue_free()


func _process(delta):
	if Input.is_action_just_pressed("darg_key"):
		selected_node_dict = {}
		init_mouse_position = get_local_mouse_position()
		var index = 0
		for node in get_tree().get_nodes_in_group("graph_nodes"):
			if node.selected:
				selected_node_dict[index] = {"node": node, "position": node.position_offset}
				index += 1

	if Input.is_action_pressed("darg_key"):
		for index in selected_node_dict:
			for node in self.get_children():
				if selected_node_dict[index]["node"] == node:
					var localposition = get_local_mouse_position()
					if init_mouse_position != localposition:
						var x = int((selected_node_dict[index]["position"][0] + localposition[0] - init_mouse_position[0]) / 10) * 10
						var y = int((selected_node_dict[index]["position"][1] + localposition[1] - init_mouse_position[1]) / 10) * 10
						node.position_offset = Vector2(x, y)
#						node.position_offset = (Vector2(node_dict[index]["position"]) + (localposition - init_mouse_position))


func spawn_node_on_cursor(node):
	var localposition = get_local_mouse_position()
	var scroll_ofset = get_scroll_ofs()
	node.position_offset = (scroll_ofset + localposition) / Vector2(get_zoom(), get_zoom())


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node, from_port, to_node, to_port)


func _on_node_close_request(node):
	var node_connections = get_connection_list()
	var instance_name = node.get_name()
	for n in node_connections:	
		if instance_name == n["from"]:
			print("disconecting ", instance_name, " from ", n["from"])
			disconnect_node(instance_name, 0, n["to"], 0)
		if instance_name == n["to"]:
			print("disconecting ", n["to"], "from ", instance_name)
			disconnect_node(n["from"], 0, instance_name, 0)
