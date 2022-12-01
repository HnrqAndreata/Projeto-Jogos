extends KinematicBody2D

var velocity = Vector2()
var direction = -1
onready var sprite := $Sprite
export (int) var dano = 30
onready var hp := 5

func get_dano():
	#sprite.play("attack")
	return dano
	
func rec_dmg(val):
	$AnimationPlayer.play("HitAnim")
	hp = hp - val
	if(hp < 1):
		self.queue_free()
	
func _ready():
	if direction == 1:
		$Sprite.flip.h = true
		$Sprite.scale.x = -2
	else:
		$Sprite.scale.x = 2	
		

func _physics_process(delta):
	if is_on_wall() or not $Antiqueda.is_colliding() and is_on_floor():
		direction = direction*-1
		scale.x = scale.x*-1
	velocity.y += 1
	sprite.play("walk")
	velocity.x = 50*direction
	if(hp<1):
		self.queue_free()
	
	move_and_slide(velocity, Vector2.UP)
	
