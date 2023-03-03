extends GraphNode

@onready var text_edit = $MarginContainer/VBoxContainer/TextBlock/TextEdit
@onready var signal_selection_option = $MarginContainer/VBoxContainer/SignalListBlock/SignalSelectionBlock/SignalOption
@onready var signal_scroll_container = $MarginContainer/VBoxContainer/SignalListBlock/ScrollContainer/VBoxContainer
@onready var select_node_type = $MarginContainer/VBoxContainer/NodeTypeBlock/NodeTypeOption
@onready var signal_list_block = $MarginContainer/VBoxContainer/SignalListBlock
@onready var signal_option = $MarginContainer/VBoxContainer/SignalListBlock/SignalSelectionBlock/SignalOption


func _ready():
	self.title = select_node_type.get_item_text(select_node_type.get_selected_id())
	for sig in GlobalSettings.signal_dict:
		signal_option.add_item(GlobalSettings.signal_dict[sig]["signal_name"])


func change_color_request(color):
	self.get_theme_stylebox("frame").bg_color = color
	self.get_theme_stylebox("selected_frame").bg_color = color


func _on_expand_toggled(button_pressed):
	if button_pressed:
		self.set_size(Vector2(401, 401))
		text_edit.set_fit_content_height_enabled(true)
	else:
		text_edit.set_fit_content_height_enabled(false)
		# Resize to make shrink graph node container
		self.set_size(Vector2(400, 400))


func _on_close_request():
	GlobalServiceVariables.node_close_request(self)
	queue_free()


func _on_add_signal_pressed():
	var signal_index = signal_selection_option.get_selected_id()
	GlobalSettings.signal_dict[signal_index]
	var signal_line = load("res://Nodes/SignalLine.tscn")
	signal_line = signal_line.instantiate()
	signal_scroll_container.add_child(signal_line)
	signal_line.add_to_group("signals")
	signal_line.set_signal_name(GlobalSettings.signal_dict[signal_index]["signal_name"])


func _on_show_signal_tab_toggled(button_pressed):
	if button_pressed == true:
		signal_list_block.set_visible(true)
		self.set_size(Vector2(401, 401))
	else:
		signal_list_block.set_visible(false)
		# Resize to make shrink graph node container
		self.set_size(Vector2(400, 400))


func _on_node_type_option_item_selected(index):
	self.title = select_node_type.get_item_text(index)
