extends GraphNode


@onready var text_edit = $MarginContainer/VBoxContainer/TextBlock/TextEdit
@onready var signal_selection_list = $MarginContainer/VBoxContainer/SignalListBlock/SignalSelectionBlock/SignalOption
@onready var signal_list_block = $MarginContainer/VBoxContainer/SignalListBlock
@onready var select_node_type = $MarginContainer/VBoxContainer/NodeTypeBlock/NodeTypeOption
var default_node_size = Vector2(400, 400)


func _ready():
	self.title = select_node_type.get_item_text(select_node_type.get_selected_id())


func change_color_request(color):
	self.get_theme_stylebox("frame").bg_color = color
	self.get_theme_stylebox("selected_frame").bg_color = color


func _on_expand_toggled(button_pressed):
	if button_pressed:
		text_edit.set_fit_content_height_enabled(true)
	else:
		text_edit.set_fit_content_height_enabled(false)


func _on_close_request():
	GlobalServiceVariables.node_close_request(self)
	queue_free()


func _on_add_signal_pressed():
	var signal_line = load("res://Nodes/SignalLine.tscn")
	signal_line = signal_line.instantiate()
	signal_list_block.add_child(signal_line)
	signal_line.add_to_group("signals")


func _on_show_signal_tab_toggled(button_pressed):
	if button_pressed == true:
		signal_list_block.set_visible(true)
	else:
		signal_list_block.set_visible(false)


func _on_node_type_option_item_selected(index):
	self.title = select_node_type.get_item_text(index)
