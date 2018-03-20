extends StaticBody2D

onready var timer = $Timer
onready var dude = get_parent().get_node("dude")
onready var head = get_parent().get_node("head")
export var head_signal =false
export var dude_signal =false

var flicker = false

func _ready():
	if(dude_signal):
		dude.connect("ded", self, "_on_ded")
	if(head_signal):
		head.connect("ded", self, "_on_ded")
	pass

func _process(delta):
	if(flicker):
		if(visible):
			hide()
		else:
			show()
	pass

func _on_ded():
	timer.start()
	flicker = true
	pass


func _on_Timer_timeout():
	queue_free()
	pass # replace with function body
