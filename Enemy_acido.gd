extends KinematicBody2D

var velocity = Vector2()
var direction = 1
onready var sprite := $AnimatedSprite
export (int) var dano = 10
onready var hp := 2
onready var player := get_tree().get_root().get_node("Level2/Player")
onready var bullet :=  preload("res://Scenes/EnemyBullet2.tscn")

func get_dano():
	return dano

func _ready() -> void:
	$Timer.start(2.0)

func rec_dmg(val):
	hp = hp - val
	if(hp < 1):
		self.queue_free()
		
func attack():
	if $Timer.time_left<0.5 and get_node("VisibilityNotifier2D").is_on_screen():
		$Timer.start(6.0)
		var vec_to_player = (player.position - position).normalized()
		var bulletNode := bullet.instance()
		bulletNode.position.x = global_position.x - 30
		bulletNode.position.y = global_position.y
		bulletNode.set_vec(vec_to_player, vec_to_player.angle())
		owner.add_child(bulletNode)
	

func _physics_process(delta):
	attack()
	if ((player.position.x - position.x) > 0):
		scale.x = abs(scale.x)*1
		
	#velocity.y += 1
	
	move_and_slide(velocity, Vector2.UP)
	


func _on_VisibilityNotifier2D2_screen_entered() -> void:
	pass # Replace with function body.
