extends KinematicBody2D

export (PackedScene) var projectile:PackedScene

onready var body = $Body
onready var cannon = $Cannon
onready var fire_pos = $Cannon/FirePosition
onready var animation_player = $AnimationPlayer
onready var audio = $AudioPlayer

var velocity:Vector2 = Vector2.ZERO
var floor_normal:Vector2 = Vector2.UP
var gravity:float = 10
var speed_limit:float = 600
var acceleration:float = 20
var friction_weight:float = 0.1
var jump_speed:float = 500

var container

func _ready():
	add_to_group("player")

func initialize(_container):
	container = _container

func handle_input():
	if Input.is_action_just_pressed("fire"):
		audio.attack()
		fire()
	
	var x_dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if x_dir != 0:
		velocity.x = clamp(velocity.x + (x_dir * acceleration), -speed_limit, speed_limit)
	else:
		velocity.x = velocity.x - (velocity.x * friction_weight) if abs(velocity.x) > 1.0 else 0.0
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_speed
		animation_player.play("jump")
	elif is_on_floor() and x_dir != 0:
		animation_player.play("walk")
	elif is_on_floor() and x_dir == 0:
		animation_player.play("idle")
		
	return x_dir
		
func handle_animation(x_dir):
	if x_dir < 0:
		body.flip_h = true
		body.offset.x = -50
	elif x_dir > 0:
		body.flip_h = false
		body.offset.x = 50

func _physics_process(_delta):
	cannon.look_at(get_global_mouse_position())
	
	var x_dir = handle_input()
	handle_animation(x_dir)

	velocity.y += gravity
	velocity = move_and_slide(velocity, floor_normal)
	
func fire():
	var proj = projectile.instance()
	proj.initialize(container, cannon.global_position, cannon.global_position.direction_to(fire_pos.global_position), true)

func to_start_position():
	global_position = container.start_position.global_position
	
func hit():
	audio.hit()

#	var x_dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
#	position.x += x_dir * velocity * delta
#	var y_dir = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
#	position.y += y_dir * velocity * delta

#	velocity.x += x_dir * 10
