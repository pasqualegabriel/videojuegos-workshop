extends Node

onready var player = $Player
onready var start_position = $StartPosition
onready var menu = $Menu

func _ready():
	player.initialize(self)
	menu.initialize(self)

func _on_Limit_body_entered(body):
	if body.is_in_group("player"):
		body.to_start_position()

func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.play()
