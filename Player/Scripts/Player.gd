extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 4.0
export (int) var jump_speed = 900
export (int) var gravity = 2000
export (int) var xgun = 30
export (int) var ygun = 30
export (float) var timer = 1.0
export (float) var timer_invencivel = 3.0
export (int) var hp = 100
export (int) var knockback_spd = 10000


onready var sprite := $Sprite
onready var fase := get_parent().get_name()
onready var bullet :=  preload("res://Scenes/Bullet.tscn")
onready var hpBar := get_tree().get_root().get_node(get_parent().name+"/CanvasLayer/Control")
onready var gunShotSFX: AudioStream = preload("res://SFX/GunShotSFX.ogg") 

var velocity := Vector2.ZERO
var dir := 1
var hit_dir :=1

func _ready():
	$Timer.start(timer)

func damage(dano):
	hp = hp - dano
	hpBar.updateBar(hp)

func get_side_input():
	speed = 200
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
			$AudioStreamPlayer2D.playAudio(0)
	else:
		sprite.play("idle")
		 
	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		#sprite.play("jump")
		velocity.y = -jump_speed
		speed += 200		

func _physics_process(delta):
	velocity.y += gravity * delta
	get_side_input()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	var collided = $Area2D.get_overlapping_areas()
	var dano = 20
	
	if(position.y > 650):
		get_tree().change_scene("res://Scenes/GameOver1.tscn")

	elif(collided.size() > 0 and $Invencivel.time_left==0):
		if(collided[0].get_name() == "Carro"):
			get_tree().change_scene("res://Scenes/Level2.tscn")
		else:
			$Invencivel.start(timer)
			dano = collided[0].get_owner().get_dano()
			damage(dano)
			if(collided[0].get_owner().position.x>position.x):
				velocity.x = -knockback_spd
				velocity.y = -250
			else:
				velocity.x = knockback_spd
				velocity.y = -250
			velocity = move_and_slide(velocity, Vector2.UP)
			if(hp < 1):
				get_tree().change_scene("res://Scenes/GameOver1.tscn")
				
