extends CanvasLayer

onready var lives = $Lives
onready var game_over = $GameOver
onready var game_over_rect = $GameOverRect

var _heartNum = 3

var container

func initialize(_container):
	container = _container

func _ready():
	lives.text = "LIVES: " + str(_heartNum)
	game_over.hide()
	game_over_rect.hide()
	
func hit():
	_heartNum -= 1
	lives.text = "LIVES: " + str(_heartNum)
	if _heartNum == 0:
		get_tree().paused = true
		game_over.show()
		game_over_rect.show()
		yield(get_tree().create_timer(2), "timeout")
		get_tree().paused = false
		get_tree().change_scene("res://Main.tscn")
