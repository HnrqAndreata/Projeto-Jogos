extends KinematicBody2D

var velocity = Vector2()
var direction = 1
onready var sprite := $AnimatedSprite
export (int) var dano = 10
onready var hp := 2

func get_dano():
	return dano

func rec_dmg():
	$AnimationPlayer.play("HitAnim")
	hp = hp - 1
	if(hp < 1):
		self.queue_free()
		
func attack():
	pass

func _physics_process(delta):
	if (is_on_wall() or not get_node("VisibilityNotifier2D").is_on_screen()):
		direction = direction*-1
		scale.x = scale.x*-1
		
	#velocity.y += 1
	sprite.play("walk")
	velocity.x = 50*direction
	
	move_and_slide(velocity, Vector2.UP)
	
