extends Node

signal UPDATE_NODE_CONNCETIONS
signal NODE_CLOSE_REQUEST


func update_node_connections():
	emit_signal("UPDATE_NODE_CONNCETIONS")


func node_close_request(node):
	emit_signal("NODE_CLOSE_REQUEST", node)
