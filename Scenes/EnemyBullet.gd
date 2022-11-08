extends KinematicBody2D

onready var velocity := Vector2()
onready var speed := 5
onready var direction := 1
onready var angle := 1

func set_direction(dir):
	direction = dir;
	velocity.x  = speed * direction

func set_angle(ang):
	angle = ang;

func _physics_process(_delta):
	var collide = move_and_collide(velocity)
	if(collide):
		#var teste = collide.collider.body
		if("Enemy" in collide.collider.name):
		#if(collide.collider.body.is_in_group("Enemy")):
			print(collide.collider)
			collide.collider.rec_dmg()
		queue_free()
