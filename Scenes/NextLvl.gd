extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var selected := $GUI/Retry
export (int) var speed = 5


func _ready() -> void:
	$GUI/Retry.bbcode_text = "[wave amp=50 freq=5][color=#fff500]NEXT LEVEL[/color][/wave]"
	

func get_input():
	if(Input.is_action_just_pressed("ui_accept")):
		if(selected == $GUI/Quit):
			get_tree().quit()
		else:
			get_tree().change_scene("res://Scenes/Level2.tscn")


func _process(_delta: float) -> void:
	get_input()

