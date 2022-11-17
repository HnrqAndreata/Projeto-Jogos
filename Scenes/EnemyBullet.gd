extends KinematicBody2D

onready var velocity := Vector2()
onready var speed := 3
onready var vec_to_player
onready var angle
export (int) var dano = 10

func get_dano():
	return dano

func set_vec(vec, ang):
	vec_to_player = vec
	angle = ang

func _ready() -> void:
	print("vetor: ",vec_to_player, " angulo: ", angle)
func _physics_process(_delta):
	rotation = angle
	var collide = move_and_collide( vec_to_player * speed)
	if(collide):
		queue_free()
