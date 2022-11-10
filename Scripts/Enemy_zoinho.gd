extends KinematicBody2D

var velocity = Vector2()
var direction = 1
onready var sprite := $AnimatedSprite
export (int) var dano = 10
onready var hp := 2
onready var player := get_tree().get_root().get_node("Level1/Player")
onready var bullet :=  preload("res://Scenes/EnemyBullet.tscn")

func get_dano():
	return dano

func _ready() -> void:
	$Timer.start(1.0)

func rec_dmg():
	$AnimationPlayer.play("HitAnim")
	hp = hp - 1
	if(hp < 1):
		self.queue_free()
		
func attack():
	var vec_to_player = (player.position - position).normalized()
	var bulletNode := bullet.instance()
	owner.add_child(bulletNode)
	bulletNode.set_vec(vec_to_player, vec_to_player.angle())
	$Timer.start(1.0)

func _physics_process(delta):
	#if $Timer.time_left==0:
		#print("timer ended")
	attack()
	if (is_on_wall() or not get_node("VisibilityNotifier2D").is_on_screen()):
		direction = direction*-1
		scale.x = scale.x*-1
		
	#velocity.y += 1
	sprite.play("walk")
	velocity.x = 50*direction
	
	move_and_slide(velocity, Vector2.UP)
	
