extends KinematicBody2D

onready var velocity := Vector2()
onready var speed := 5
onready var vec_to_player
onready var angle

func set_vec(vec, ang):
	vec_to_player = vec
	angle = ang

func _ready() -> void:
	print("vetor: ",vec_to_player, " angulo: ", angle)
func _physics_process(_delta):
	rotation = angle
	var collide = move_and_collide( vec_to_player * speed)
	if(collide):
		#var teste = collide.collider.body
		if("Player" in collide.collider.name):
		#if(collide.collider.body.is_in_group("Enemy")):
			print(collide.collider)
		queue_free()
