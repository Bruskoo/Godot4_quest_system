extends Node

signal TEXT_EDIT_MOUSE_ENTERED
signal TEXT_EDIT_MOUSE_EXITED

func text_edit_mouse_entered():
	emit_signal("TEXT_EDIT_MOUSE_ENTERED")

func text_edit_mouse_exited():
	emit_signal("TEXT_EDIT_MOUSE_EXITED")
