extends Window

@onready var save_path_line_edit = $MarginContainer/VBoxContainer/SavePath/SavePathLineEdit
@onready var signal_scroll_container = $MarginContainer/VBoxContainer/SignalContainer/ScrollContainer/VBoxContainer
@onready var character_scroll_container = $MarginContainer/VBoxContainer/CharacterContainer/ScrollContainer2/VBoxContainer


func _ready():
	update_settings()


func _on_close_requested():
	queue_free()


func update_settings():
	save_path_line_edit.set_text(GlobalSettings.save_path)
	
	# signals
	for n in signal_scroll_container.get_children():
		signal_scroll_container.remove_child(n)
		n.queue_free()
	
	for index in GlobalSettings.signal_dict:
		var signal_name = GlobalSettings.signal_dict[index]["signal_name"]
		var signal_type = GlobalSettings.signal_dict[index]["signal_type"]
		var create_signal_line = load("res://Windows/CreateSignalLine.tscn")
		create_signal_line = create_signal_line.instantiate()
		signal_scroll_container.add_child(create_signal_line)
		create_signal_line.add_to_group("signals")
		create_signal_line.set_values(signal_name, signal_type)
		
	# characters
	for n in character_scroll_container.get_children():
		character_scroll_container.remove_child(n)
		n.queue_free()
	
	for index in GlobalSettings.characters_dict:
		var character_name = GlobalSettings.characters_dict[index]["character_name"]
		var create_character_line = load("res://Windows/CreateCharacterLine.tscn")
		create_character_line = create_character_line.instantiate()
		character_scroll_container.add_child(create_character_line)
		create_character_line.add_to_group("characters")
		create_character_line.set_values(character_name)
		
	

func _on_save_settings_pressed():
	var save_path = save_path_line_edit.text.replace("\\", "/")
	
	# signals
	var signal_dict = {}
	var signal_index = 0
	for node in signal_scroll_container.get_children():
		signal_dict[signal_index] = node.get_values()
		signal_index += 1
	
	# characters
	var characters_dict = {}
	var character_index = 0
	for node in character_scroll_container.get_children():
		characters_dict[character_index] = node.get_values()
		character_index += 1
	
	GlobalSettings.load_settings()
	GlobalSettings.save_settings(save_path, signal_dict, characters_dict)
	update_settings()


func _on_defaults_pressed():
	GlobalSettings.defaut_settings()
	GlobalSettings.load_settings()
	update_settings()


func _on_add_signal_pressed():
	var create_signal_line = load("res://Windows/CreateSignalLine.tscn")
	create_signal_line = create_signal_line.instantiate()
	signal_scroll_container.add_child(create_signal_line)
	create_signal_line.add_to_group("signals")


func _on_add_character_pressed():
	var create_character_line = load("res://Windows/CreateCharacterLine.tscn")
	create_character_line = create_character_line.instantiate()
	character_scroll_container.add_child(create_character_line)
	character_scroll_container.add_to_group("characters")
