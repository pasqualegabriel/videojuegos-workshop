extends KinematicBody2D

var velocity:Vector2 = Vector2.ZERO
var floor_normal:Vector2 = Vector2.UP
var gravity:float = 10
var speed_limit:float = 600
var acceleration:float = 20
var friction_weight:float = 0.1
var jump_speed:float = 500

func _physics_process(_delta):
	var x_dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if x_dir != 0:
		velocity.x = clamp(velocity.x + (x_dir * acceleration), -speed_limit, speed_limit)
	else:
		velocity.x = velocity.x - (velocity.x * friction_weight) if abs(velocity.x) > 1 else 0
		
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y -= jump_speed

	velocity.y += gravity
	velocity = move_and_slide(velocity, floor_normal)
	
#	var x_dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
#	position.x += x_dir * velocity * delta
#	var y_dir = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
#	position.y += y_dir * velocity * delta

#	velocity.x += x_dir * 10

