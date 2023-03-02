extends Button

@onready var main_node = get_owner()

func _ready():
	self.connect("pressed", _on_pressed)


func _on_pressed():
	print(main_node)
	
	var color = get_theme_stylebox("normal").get_bg_color()
	main_node.change_color_request(color)
#	GlobalServiceVariables.change_color_request(color)
