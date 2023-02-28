extends Node

var save_path
var config_file = ConfigFile.new()


func _ready():
	load_settings()


func load_settings():
	var err = config_file.load("user://settings.cfg")
	if err != OK:
		defaut_settings()
	for setting in config_file.get_sections():
		save_path = config_file.get_value(setting, "save_path")


func save_settings(save_path):
	config_file.set_value("", "save_path", save_path)
	config_file.save("user://settings.cfg")
	load_settings()


func defaut_settings():
	config_file.set_value("", "save_path", "user://")
	config_file.save("user://settings.cfg")
