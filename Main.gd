extends Node

onready var player = $Player
onready var start_position = $StartPosition

func _ready():
	player.initialize(self)

func _on_Limit_body_entered(body):
	if body.is_in_group("player"):
		body.to_start_position()
