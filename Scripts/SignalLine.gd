extends HBoxContainer


@onready var signal_name_lable = $SignalName
signal update_size


func _on_close_pressed():
	queue_free()
