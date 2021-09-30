extends StaticBody2D

export (PackedScene) var projectile:PackedScene

onready var fire_timer = $FireTimer

var container

func _ready():
	add_to_group("turret")
	fire_timer.start()

func initialize(_container):
	container = _container

func _on_FireTimer_timeout():
	fire()

func fire():
	var proj = projectile.instance()
	proj.initialize(get_parent(), global_position, global_position.direction_to(get_parent().player.global_position))
	fire_timer.start()

