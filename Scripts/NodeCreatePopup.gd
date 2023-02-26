extends PopupMenu


var globals = GlobalServiceVariables


func _ready():
	popup()
#	set_hide_on_item_selection(true)


func _on_text_node_pressed():
	globals.node_create_request("text_node")
	queue_free()


func _on_option_node_pressed():
	globals.node_create_request("option_node")
	queue_free()
