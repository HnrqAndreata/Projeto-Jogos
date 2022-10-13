extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var velocity := Vector2()
onready var speed := 5
onready var direction := 1

func set_direction(dir):
	direction = dir;

func _ready():
	speed = speed * direction
func get_input():
	velocity.x = speed

func _physics_process(delta):
	get_input();
	var collide = move_and_collide(velocity)
	if(collide):
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
