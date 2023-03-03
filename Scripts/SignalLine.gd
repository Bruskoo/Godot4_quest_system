extends HBoxContainer

@onready var signal_name_lable = $SignalName


func set_signal_name(singnal_name):
	signal_name_lable.text = singnal_name


func _on_close_pressed():
	queue_free()
