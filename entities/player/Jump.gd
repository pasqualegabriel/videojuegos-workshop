extends AudioStreamPlayer

onready var jump_audio = load("res://sounds/Jump.ogg") 
onready var walk_audio = load("res://sounds/Leaves1.ogg") 
onready var attack_audio = load("res://sounds/PlayerAttack.ogg") 
onready var hit_audio = load("res://sounds/playerHurt.wav") 

func _ready():
	jump_audio.loop = false
	walk_audio.loop = false
	attack_audio.loop = false
	
func hit():
	self.stream = hit_audio
	self.play()

func attack():
	self.stream = attack_audio
	self.play()
#	yield(get_tree().create_timer(1.09), "timeout")
#	self.set_volume_db(-15)
