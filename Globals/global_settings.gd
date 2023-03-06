extends Node

var save_path
var config_file = ConfigFile.new()
var signal_dict = {}
var characters_dict = {}


func _ready():
	load_settings()


func load_settings():
	var err = config_file.load("user://settings.cfg")
	if err != OK:
		defaut_settings()
	for setting in config_file.get_sections():
		save_path = config_file.get_value(setting, "save_path")
		signal_dict = config_file.get_value(setting, "signals")
		characters_dict = config_file.get_value(setting, "characters")


func save_settings(save_path, signal_dict, characters_dict):
	config_file.set_value("", "save_path", save_path)
	config_file.set_value("", "signals", signal_dict)
	config_file.set_value("", "characters", characters_dict)
	config_file.save("user://settings.cfg")
	load_settings()


func defaut_settings():
	config_file.set_value("", "save_path", "user://")
	config_file.set_value("", "signals", "")
	config_file.set_value("", "characters", "")
	config_file.save("user://settings.cfg")
