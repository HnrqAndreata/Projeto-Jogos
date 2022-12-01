extends KinematicBody2D

onready var velocity := Vector2()
onready var speed := 3
onready var direction := 1
onready var damage := 3
export (int) var gravity = 1

func set_direction(dir):
	direction = dir;
	velocity.x  = speed * direction

func _physics_process(_delta):
	velocity.y += gravity * _delta
	var collide = move_and_collide(velocity)
	$AnimatedSprite.play("default")
	if(collide):
		#var teste = collide.collider.body
		if("Enemy" in collide.collider.name):
		#if(collide.collider.body.is_in_group("Enemy")):
			print(collide.collider)
			collide.collider.rec_dmg(3)
 
		queue_free()
