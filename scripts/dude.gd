extends KinematicBody2D

const SPEED = 20
var motion = Vector2(0,1)
onready var anim = $AnimationPlayer
onready var twalk = $twalk
onready var tflicker = $tflicker
var flickers = false
var stop = false
signal ded

func _ready():
	add_to_group("dude")
	pass

func _process(delta):
	if(flickers):
		if(visible):
			hide()
		else:
			show()
	if(!stop):	
		move_and_collide(motion*SPEED*delta)
		if motion.x > 0:
			if anim.get_current_animation() != "walk_right" || !anim.is_playing():
					anim.play("walk_right")
		elif motion.x <0:
			if anim.get_current_animation() != "walk_left" || !anim.is_playing():
				anim.play("walk_left")
		elif motion.y > 0:
			if anim.get_current_animation() != "walk_down" || !anim.is_playing():
				anim.play("walk_down")
		elif motion.y < 0:
			if anim.get_current_animation() != "walk_up" || !anim.is_playing():
				anim.play("walk_up")
	pass


func _on_Timer_timeout():
	randomize()
	$twalk.wait_time = rand_range(0.8, 2.4)
	rand_dir()
	pass # replace with function body
	
func rand_dir():
	if(motion.x!=0):
		var i = randi()%2
		if(i==0):
			motion.y = -1
		else:
			motion.y = 1
		motion.x=0
	elif(motion.y!=0):
		var i = randi()%2
		if(i==0):
			motion.x = -1
		else:
			motion.x = 1
		motion.y=0
	pass
	
func die():
	$scream.play()
	emit_signal("ded")
	anim.stop()
	twalk.stop()
	flickers = true
	tflicker.start()
	stop = true
	pass


func _on_tflicker_timeout():
	flickers = false
	hide()
	$CollisionShape2D.set_disabled(true)
	pass # replace with function body
