extends HBoxContainer

@onready var character_name_line = $CharacterName


func get_values():
	var dict = {}
	dict["character_name"] = character_name_line.get_text()
	return dict

func set_values(character_name):
	character_name_line.text = character_name


func _on_close_pressed():
	queue_free()
