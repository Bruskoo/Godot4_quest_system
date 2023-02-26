extends Node

signal NODE_CREATE_REQUEST
signal UPDATE_NODE_CONNCETIONS
signal NODE_CLOSE_REQUEST


func node_create_request(node_type):
	emit_signal("NODE_CREATE_REQUEST", node_type)


func update_node_connections():
	emit_signal("UPDATE_NODE_CONNCETIONS")


func node_close_request(node):
	emit_signal("NODE_CLOSE_REQUEST", node)
