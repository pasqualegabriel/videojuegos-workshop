extends Area2D

var container
var direction:Vector2
var velocity:float = 600

func initialize(_container, init_pos, _direction):
	container = _container
	container.add_child(self)
	direction = _direction
	global_position = init_pos

func _physics_process(delta):
	global_position += direction * velocity * delta
