extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var velocity := Vector2()
onready var speed := 5
onready var direction := 1

func set_direction(dir):
	direction = dir;
	velocity.x  = speed * direction

func _physics_process(_delta):
	var collide = move_and_collide(velocity)
	if(collide):
		#print(collide.collider.name)
		if(collide.collider.name == "Enemy"):
			print(collide.collider)
			collide.collider.queue_free()
			#ar enemy = get_node("Enemy")
			#rint(enemy)
			#f enemy != null:
		#	enemy.die()   
		queue_free()

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#if(sprite.scale.x > 0):
	#	_physics_process(1)
	#else:
	#_physics_process(-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
