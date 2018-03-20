extends Area2D


export var SPEEDX = 140
var fireball = preload("res://scenes/fireball.tscn")
var movement =0
var positionnext = 0
var dirx = 1
var dir = 1
var hp = 15
var ready = false
var flicker = false
onready var t1 = $Timer
onready var t2 = $Timer2
onready var t3 = $Timer3
onready var player = get_parent().get_node("player")
onready var anim = $AnimationPlayer
onready var text = get_parent().get_node("CanvasLayer").get_node("Label")
signal ded

func _ready():
	add_to_group("head")
	text.connect("ready",self,"_on_ready")
	pass

func _process(delta):
	if(flicker):
		if(visible):
			hide()
		else:
			show()
	
	if(ready):
		
		if(position.x<-80|| position.x>80):
			dirx *= -1
		positionnext = dirx*SPEEDX*delta
		position.x += positionnext
		if(hp<=0):
			die()
	pass
	



func _on_Timer_timeout():
	var newfire = fireball.instance()
	newfire.position = position
	get_parent().add_child(newfire)
#	$laser.play()
	pass # replace with function body


func _on_head_area_entered( area ):
	if(area.is_in_group("damage")):
		take_damage()
	pass # replace with function body

func take_damage():
	if(ready):
		hp -= 1
		$hit.play()
		if(hp==12 && anim.current_animation!="damaged"):
			anim.play("damaged")
		elif(hp==8 && anim.current_animation!="damaged2"):
			anim.play("damaged2")
		elif(hp==4 && anim.current_animation!="damaged3"):
			anim.play("damaged3")	
	pass
	
func die():
	positionnext = 0
	t1.stop()
	t2.stop()
	flicker = true
	ready = false
	emit_signal("ded")
	
	t3.start()

func _on_Timer2_timeout():
	for i in range(5):
		var newfire = fireball.instance()
		newfire.init(true, i)
		newfire.position = position
		get_parent().add_child(newfire)
#		$laser.play()
	pass # replace with function body

func _on_ready():
	ready=true
	t1.start()
	t2.start()
	pass

func _on_Timer3_timeout():
	queue_free()
	pass # replace with function body


func _on_head_body_entered( body ):
	if(body.is_in_group("player")):
		body.hit()
	pass # replace with function body
