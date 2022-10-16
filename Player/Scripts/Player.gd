extends KinematicBody2D

export (int) var speed = 100
export (float) var rotation_speed = 4.0
export (int) var jump_speed = 1000
export (int) var gravity = 3000
export (int) var xgun = 30
export (int) var ygun = 30
export (float) var timer = 1.0

onready var sprite := $Sprite
onready var bullet :=  preload("res://Bullet.tscn")

var velocity := Vector2.ZERO
var dir := 1

func get_side_input():
	velocity.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	velocity.x *= speed
	if velocity.x > 0:
		sprite.play("right")
		sprite.scale.x = abs(sprite.scale.x)
		dir = 1
	elif velocity.x < 0:
		sprite.play("left")
		sprite.scale.x = -1 * abs(sprite.scale.x)
		dir = -1
	elif Input.get_action_strength("ui_accept"):
		sprite.play("shoot")
		if $Timer.time_left==0:
			$Timer.start(timer)
			var bulletNode := bullet.instance()
			bulletNode.position.x = global_position.x + (xgun*dir)
			bulletNode.position.y = global_position.y - ygun
			owner.add_child(bulletNode)
			bulletNode.set_direction(dir)
	else:
		sprite.play("idle")
		 
	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		sprite.play("jump")
		velocity.y = -jump_speed
		
func _physics_process(delta):

	velocity.y += gravity * delta
	get_side_input()
	
	velocity = move_and_slide(velocity, Vector2.UP)
