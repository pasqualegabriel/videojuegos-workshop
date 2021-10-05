extends Area2D

var container

func initialize(_container):
	container = _container

func _on_Star_body_entered(body):
	if body.is_in_group("player"):
		OS.shell_open("https://web.flow.com.ar")
		container.menu.win()
		
