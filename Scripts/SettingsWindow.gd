extends Window

@onready var save_path_line_edit = $MarginContainer/VBoxContainer/SavePath/SavePathLineEdit
@onready var scroll_container = $MarginContainer/VBoxContainer/SignalContainer/ScrollContainer/VBoxContainer


func _ready():
	update_settings()


func _on_close_requested():
	queue_free()


func update_settings():
	save_path_line_edit.set_text(GlobalSettings.save_path)
	
	for n in scroll_container.get_children():
		scroll_container.remove_child(n)
		n.queue_free()
	
	for index in GlobalSettings.signal_dict:
		var signal_name = GlobalSettings.signal_dict[index]["signal_name"]
		var signal_type = GlobalSettings.signal_dict[index]["signal_type"]
		var create_signal_line = load("res://Windows/CreateSignalLine.tscn")
		create_signal_line = create_signal_line.instantiate()
		scroll_container.add_child(create_signal_line)
		create_signal_line.add_to_group("signals")
		create_signal_line.set_values(signal_name, signal_type)


func _on_save_settings_pressed():
	var signal_dict = {}
	var index = 0
	var save_path = save_path_line_edit.text.replace("\\", "/")
	for node in scroll_container.get_children():
		signal_dict[index] = node.get_values()
		index += 1
	GlobalSettings.load_settings()
	GlobalSettings.save_settings(save_path, signal_dict)
	update_settings()


func _on_defaults_pressed():
	GlobalSettings.defaut_settings()
	GlobalSettings.load_settings()
	update_settings()


func _on_add_signal_pressed():
	var create_signal_line = load("res://Windows/CreateSignalLine.tscn")
	create_signal_line = create_signal_line.instantiate()
	scroll_container.add_child(create_signal_line)
	create_signal_line.add_to_group("signals")
