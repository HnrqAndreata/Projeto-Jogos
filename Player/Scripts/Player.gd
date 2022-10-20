extends KinematicBody2D

export (int) var speed = 150
export (float) var rotation_speed = 4.0
export (int) var jump_speed = 1000
export (int) var gravity = 3000
export (int) var xgun = 30
export (int) var ygun = 30
export (float) var timer = 1.0
export (float) var max_health = 100

signal damaged(hp)
signal killed()

onready var sprite := $Sprite
onready var bullet :=  preload("res://Bullet.tscn")
onready var barrahp :=  $HP
onready var hp = max_health setget _set_hp
onready var invulnerabilidade = $Timer_sem_dano

var velocity := Vector2.ZERO
var dir := 1

func _set_hp(value):
	var prev_hp = hp
	hp = clamp(value, 0, max_health)
	if hp != prev_hp:
		emit_signal("damaged",hp)
		if hp == 0:
			kill()
			emit_signal("killed")

func damage(dano):
	if(invulnerabilidade.is_stopped()):
		invulnerabilidade.start()
		_set_hp(hp - dano)
	
func kill():
	pass

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
		
#Dano so ta funcionando quando o player colide com o inimigo, nao quando o inimigo colide com o player
func _physics_process(delta):
	if(hp <= 0):
		$Player.queue.free()
	velocity.y += gravity * delta
	get_side_input()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	var collide = get_last_slide_collision()
	if(collide):
		if("Enemy" in collide.collider.name):
			damage(20)
		if($HP.value == 0):
			get_tree().change_scene("res://GameOver.tscn")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	get_tree().change_scene("res://GameOver.tscn")
