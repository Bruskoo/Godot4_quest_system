extends GraphNode

@onready var text_edit = $MarginContainer/VBoxContainer/HBoxContainer3/TextEdit
@onready var previos_size = text_edit.size

@onready var color1_button = $MarginContainer/VBoxContainer/HBoxContainer4/Color1
@onready var color2_button = $MarginContainer/VBoxContainer/HBoxContainer4/Color2
@onready var color3_button = $MarginContainer/VBoxContainer/HBoxContainer4/Color3
@onready var color4_button = $MarginContainer/VBoxContainer/HBoxContainer4/Color4

func _ready():
	pass


func _on_expand_toggled(button_pressed):
	if button_pressed:
		text_edit.set_fit_content_height_enabled(true)
	else:
		text_edit.set_fit_content_height_enabled(false)
		text_edit.size = previos_size
		self.size = Vector2(400, 250)


func _on_close_request():
	GlobalServiceVariables.node_close_request(self)
	queue_free()


func _on_color_1_pressed():
	print(color1_button.get_theme_stylebox("normal").get_bg_color())
	self.get_theme_stylebox("frame").bg_color = color1_button.get_theme_stylebox("normal").get_bg_color()


func _on_color_2_pressed():
	self.get_theme_stylebox("frame").bg_color = color2_button.get_theme_stylebox("normal").get_bg_color()


func _on_color_3_pressed():
	self.get_theme_stylebox("frame").bg_color = color3_button.get_theme_stylebox("normal").get_bg_color()


func _on_color_4_pressed():
	self.get_theme_stylebox("frame").bg_color = color4_button.get_theme_stylebox("normal").get_bg_color()
