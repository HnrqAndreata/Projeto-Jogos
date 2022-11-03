extends KinematicBody2D

var velocity = Vector2()
var direction = -1
onready var sprite := $Sprite
export (int) var dano = 30
onready var tween := $Tween
onready var hp := 5

func get_dano():
	return dano
	
func anim_hit():
	tween.interpolate_property(self, "modulate", Color(1, 1, 1), Color(1, 1, 1, 0.498039), 1.0)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0.498039), Color(1, 1, 1), Tween.TRANS_LINEAR, Tween.EASE_IN, 1.0)
	hp = hp - 1
func _ready():
	tween.start()
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
	sprite.play("idle")
	velocity.x = 50*direction
	if(hp<1):
		self.queue_free()
	
	move_and_slide(velocity, Vector2.UP)
	
