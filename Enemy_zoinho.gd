extends KinematicBody2D

var velocity = Vector2()
var direction = 1
onready var sprite := $AnimatedSprite



func _physics_process(delta):
	if (is_on_wall() or not get_node("VisibilityNotifier2D").is_on_screen()):
		direction = direction*-1
		scale.x = scale.x*-1
		
	#velocity.y += 1
	sprite.play("walk")
	velocity.x = 50*direction
	
	move_and_slide(velocity, Vector2.UP)
	
