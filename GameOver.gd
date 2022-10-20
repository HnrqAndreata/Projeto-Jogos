extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var selected := $GUI/Retry


func _ready() -> void:
	$GUI/Retry.add_color_override("font_color",Color(1,1,0,1))


func get_input():
	var selection = Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")
	if(selection):
		if(selected == $GUI/Quit):
			selected = $GUI/Retry
			$GUI/Retry.add_color_override("font_color",Color(1,1,0,1))
			$GUI/Quit.add_color_override("font_color",Color(1,1,1,1))
		else:
			selected = $GUI/Quit
			$GUI/Quit.add_color_override("font_color",Color(1,1,0,1))
			$GUI/Retry.add_color_override("font_color",Color(1,1,1,1))
	if(Input.is_action_just_pressed("ui_accept")):
		if(selected == $GUI/Quit):
			get_tree().quit()
		else:
			get_tree().change_scene("res://Level1.tscn")


func _process(delta: float) -> void:
	get_input()

