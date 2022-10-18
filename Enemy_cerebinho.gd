extends KinematicBody2D

var velocity = Vector2()
var direction = 1
onready var sprite := $AnimatedSprite

#func _ready():
#	if direction == 1:
#		$AnimatedSprite.flip.h = true
#		$AnimatedSprite.scale.x = -2
#	else:
#		$AnimatedSprite.scale.x = 2	

func _physics_process(delta):
	if is_on_wall() or not $Antiqueda.is_colliding() and is_on_floor():
		direction = direction*-1
		scale.x = scale.x*-1
		
	velocity.y += 1
	sprite.play("idle")
	velocity.x = 50*direction
	
	move_and_slide(velocity, Vector2.UP)
	
