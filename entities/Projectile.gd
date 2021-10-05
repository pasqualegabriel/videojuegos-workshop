extends Area2D

onready var life_timer = $LifeTimer

var container
var direction:Vector2
var velocity:float = 600
var is_player_projectile:bool

func initialize(_container, init_pos, _direction, _is_player_projectile):
	container = _container
	container.add_child(self)
	direction = _direction
	global_position = init_pos
	is_player_projectile = _is_player_projectile

func _physics_process(delta):
	global_position += direction * velocity * delta

func _on_Projectile_body_entered(body):
	if body.is_in_group("player") and !is_player_projectile:
		body.hit()
		remove()
	if body.is_in_group("turret") and is_player_projectile:
		body.hit()
		remove()

func remove():
	call_deferred('bye')
	
func bye():
	get_parent().remove_child(self)
	queue_free()

func _on_LifeTimer_timeout():
	remove()
