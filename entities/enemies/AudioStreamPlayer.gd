extends AudioStreamPlayer

onready var attack_audio = load("res://sounds/catAttack.ogg")
onready var dead_audio = load("res://sounds/catDead.wav")

func _ready():
	attack_audio.loop = false
	
func dead():
	self.stream = dead_audio
	self.play()

func attack():
	self.stream = attack_audio
	self.play()
