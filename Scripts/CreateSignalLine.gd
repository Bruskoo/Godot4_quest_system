extends HBoxContainer

@onready var signal_name_label = $SignalName
@onready var signal_type_option = $SignalType


func get_values():
	var dict = {}
	dict["signal_name"] = signal_name_label.get_text()
	dict["signal_type"] = signal_type_option.get_item_text(signal_type_option.get_selected_id())
	return dict

func set_values(signal_name, signal_type):
	signal_name_label.text = signal_name
	if signal_type == "None":
		signal_type_option.select(0)
	elif signal_type == "With args":
		signal_type_option.select(1)


func _on_close_pressed():
	queue_free()
