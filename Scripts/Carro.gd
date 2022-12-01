extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var dano = 1

func get_dano():
	return dano
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since t he previous frame.
#func _process(delta):
#	pass


func _on_Carro_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	get_tree().change_scene("res://Scenes/Start.tscn")
	pass
