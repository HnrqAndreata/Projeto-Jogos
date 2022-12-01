extends KinematicBody2D

var velocity = Vector2()
var direction = 1
export (int) var dano = 15
onready var sprite := $AnimatedSprite
onready var hp := 3

	

func rec_dmg(val):
	$AnimationPlayer.play("HitAnim")
	hp = hp - val
	if(hp < 1):
		self.queue_free()
	

func get_dano():
	return dano

func _physics_process(delta):
	if is_on_wall() or not $Antiqueda.is_colliding() and is_on_floor():
		direction = direction*-1
		scale.x = scale.x*-1
		
	velocity.y += 1
	sprite.play("walk")
	velocity.x = 50*direction
	
	move_and_slide(velocity, Vector2.UP)
	
