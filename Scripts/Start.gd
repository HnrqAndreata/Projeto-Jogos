extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var selected := $GUI/Retry
export (int) var speed = 5


func _ready() -> void:
	$GUI/Retry.bbcode_text = "[wave amp=50 freq=5][color=#fff500]Start[/color][/wave]"
	

func get_input():
	var selection = Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")
	if(selection):
		if(selected == $GUI/Quit):
			selected = $GUI/Retry
			$GUI/Retry.bbcode_text = "[wave amp=50 freq=5][color=#fff500]Start[/color][/wave]"
			$GUI/Quit.bbcode_text = "[color=#ffffff]Quit[/color]"
		else:
			selected = $GUI/Quit
			$GUI/Retry.bbcode_text = "[color=#ffffff]Start[/color]"
			$GUI/Quit.bbcode_text = "[wave amp=50 freq=5][color=#fff500]Quit[/color][/wave]"
	if(Input.is_action_just_pressed("ui_accept")):
		if(selected == $GUI/Quit):
			get_tree().quit()
		else:
			get_tree().change_scene("res://Scenes/Level1.tscn")


func _process(_delta: float) -> void:
	get_input()

