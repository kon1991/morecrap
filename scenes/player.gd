extends KinematicBody2D

onready var anim = $anim
onready var sprite = $sprite
onready var hit = $hit_audio
onready var cp = get_parent().get_node("checkpoint")
onready var cam = $camera
var newknife = preload("res://scenes/knife.tscn")
var canMove1 = false
var canMove2 = false
var canAnim1 = false
var canAnim2 = false
var canKnife = false
var hasKnife = false
var lastdir = Vector2(1,0)
var hit_state = false
export var hp = 5
onready var text = get_parent().get_node("CanvasLayer").get_node("Label")

const SPEED = 80

func _ready():
	add_to_group("player")
	anim.current_animation = "walk_down"
	anim.stop()
	text.connect("trap",self,"_on_trap")
	pass

func _process(delta):
	if(hp<=0):
		die()
	if(hit_state):
		if(visible):
			hide()
		else:
			show()
	if(canMove2 && canMove1):
		move_player(delta)
	pass

func _input(event):
#	if(event.is_action_released("ui_select")):
#		if(canMove1==false):
#			canMove1 = true
#		elif(canMove1==true && canAnim1==false):
#			canAnim1=true
#		elif(canAnim1==true):
#			canAnim2=true
	if(event.is_action_released("ui_fire") && canKnife==true):
		var knife = newknife.instance()
		knife.position = position
		knife.init(lastdir)
		get_parent().add_child(knife)
	pass

func move_player(delta):
	var motion = Vector2()
	var moving = false
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0,-1)
		moving = true
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0,1)
		moving = true
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1,0)
		moving = true
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1,0)
		moving = true
		
	if motion != Vector2(0,0):
		lastdir = motion
		
	
	if(canAnim1==true && canAnim2==false):
		if(anim.current_animation!="walk_down"):
			anim.play("walk_down")
	elif(canAnim2==true): 
		if moving == false:
			anim.stop()
			sprite.set_frame(0)
		else:
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

	motion = motion.normalized() * SPEED * delta
	var collider = move_and_collide(motion)
	if(collider!=null):
		var n = collider.get_normal()
		motion = motion.slide(n)
		move_and_collide(motion)	
		
#
#		if (is_colliding()):
#			var body = get_collider()
#
#			var n = get_collision_normal()
#			motion = n.slide(motion)
#			move(motion)
		
	pass
	
func get_next_ability():
	print("wow")
	if(canMove1==false):
		canMove1 = true
	elif(canMove1==true && canAnim1==false):
		canAnim1=true
	elif(canAnim1==true):
		canAnim2=true
	pass

func hit():
	if(!hit_state):
		hit.play()
		hp -= 1
		hit_state = true
		$Timer.start()
	pass
	
func die():
	position = cp.spawnposition
	hp = 5
	pass

func end():
	canMove1 = false
	canMove2 = false
	anim.play("walk_down")
	pass

func _on_trap():
	canMove1 = true
	canMove2 = true
	canAnim1 = true
	canAnim2 = true
	canKnife = true
	hasKnife = true
	
	cam.limit_top = -180
	cam.limit_bottom = 60
	pass


func _on_Timer_timeout():
	hit_state = false
	show()
	pass # replace with function body
