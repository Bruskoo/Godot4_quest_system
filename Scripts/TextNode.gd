extends GraphNode

@onready var text_edit = $MarginContainer/VBoxContainer/TextBlock/TextEdit
@onready var character_option = $MarginContainer/VBoxContainer/CharacterBlock/CharacterOptionButton
@onready var signal_selection_option = $MarginContainer/VBoxContainer/SignalListBlock/SignalSelectionBlock/SignalOption
@onready var signal_scroll_container = $MarginContainer/VBoxContainer/SignalListBlock/ScrollContainer/VBoxContainer
@onready var select_node_type = $MarginContainer/VBoxContainer/NodeTypeBlock/NodeTypeOption
@onready var signal_list_block = $MarginContainer/VBoxContainer/SignalListBlock
@onready var signal_option = $MarginContainer/VBoxContainer/SignalListBlock/SignalSelectionBlock/SignalOption


func _ready():
	self.title = select_node_type.get_item_text(select_node_type.get_selected_id())
	update_node()


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
	if signal_index != -1:
		GlobalSettings.signal_dict[signal_index]
		var signal_line = load("res://Nodes/SignalLine.tscn")
		signal_line = signal_line.instantiate()
		signal_scroll_container.add_child(signal_line)
		signal_line.add_to_group("signals")
		signal_line.set_signal_name(GlobalSettings.signal_dict[signal_index]["signal_name"])
		update_node()


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
	
	match select_node_type.get_item_text(index):
		"Text node":
			self.get_theme_stylebox("frame").border_color = Color(0.24, 0.24, 0.25, 1)
			self.get_theme_stylebox("selected_frame").border_color = Color(0.24, 0.24, 0.25, 1)
		"Option mode":
			self.get_theme_stylebox("frame").border_color = Color(0.15, 0.21, 0.50, 1)
			self.get_theme_stylebox("selected_frame").border_color = Color(0.15, 0.21, 0.50, 1)
		"Start":
			self.get_theme_stylebox("frame").border_color = Color(0.12, 0.29, 0.14, 1)
			self.get_theme_stylebox("selected_frame").border_color = Color(0.12, 0.29, 0.14, 1)
		"End":
			self.get_theme_stylebox("frame").border_color = Color(0.43, 0.12, 0.16, 1)
			self.get_theme_stylebox("selected_frame").border_color = Color(0.43, 0.12, 0.16, 1)


func _on_signal_option_pressed():
	update_node()


func update_node():
	signal_selection_option.clear()
	for sig in GlobalSettings.signal_dict:
		signal_option.add_item(GlobalSettings.signal_dict[sig]["signal_name"])
	
	character_option.clear()
	for character_index in GlobalSettings.characters_dict:
		character_option.add_item(GlobalSettings.characters_dict[character_index]["character_name"])
