extends StaticBody2D

export (PackedScene) var projectile:PackedScene

onready var fire_timer = $FireTimer
onready var body = $Sprite

var container

func _ready():
	add_to_group("turret")
	body.play("idle")

func initialize(_container):
	container = _container
	
func _physics_process(_delta):
	body.flip_h = global_position.direction_to(get_parent().player.global_position).x < 0

func _on_FireTimer_timeout():
	fire()

func fire():
	var proj = projectile.instance()
	body.play("fire")
	proj.initialize(get_parent(), global_position, global_position.direction_to(get_parent().player.global_position), false)
	fire_timer.start()

func hit():
	call_deferred('bye')
	
func bye():
	get_parent().remove_child(self)
	queue_free()
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		fire_timer.start()

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		fire_timer.stop()

func _on_Sprite_animation_finished():
	body.play("idle")
