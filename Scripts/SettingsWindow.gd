extends Window

@onready var save_path_line_edit = $MarginContainer/VBoxContainer/HBoxContainer/SavePathLineEdit
var config_file = ConfigFile.new()


func _ready():
	update_settings()


func _on_close_requested():
	queue_free()


func update_settings():
	save_path_line_edit.set_text(GlobalSettings.save_path)


func _on_save_settings_pressed():
	var save_path = save_path_line_edit.text.replace("\\", "/")
	GlobalSettings.save_settings(save_path)
	GlobalSettings.load_settings()
	update_settings()


func _on_defaults_pressed():
	GlobalSettings.defaut_settings()
	GlobalSettings.load_settings()
	update_settings()
