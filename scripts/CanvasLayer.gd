extends CanvasLayer

onready var white = $white/anim
onready var timer1 = $timer1
onready var timer2 = $timer2
onready var theEnd = $theEnd
var ready = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	if(ready):
#
#	pass

func end():
	white.play("fade")
	$whiteout.play()
	timer1.start()
	timer2.start()
	pass


func _on_Timer_timeout():
	theEnd.show()
	pass # replace with function body


func _on_timer2_timeout():
	get_tree().change_scene("res://scenes/end.tscn")
	pass # replace with function body
