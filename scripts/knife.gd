extends Area2D

export var speed = 220
var motion = Vector2(0,0)
onready var tdissapear = $Timer
var stuck = false
onready var head = get_parent().get_node("head")
onready var wr = weakref(head)
var distance_traveled = 0

func _ready():
	add_to_group("damage")
	$knife.play()
	pass

func init(lastdir):
	if(lastdir.x==1):
		motion.x = 1
	elif(lastdir.x==-1):
		motion.x = -1
		$Sprite.set_flip_h(true)
	elif(lastdir.y==1):
		motion.y = 1
		rotation = deg2rad(90)
	elif(lastdir.y==-1):
		motion.y = -1
		rotation = deg2rad(270)
	pass
	
func _process(delta):
	if(distance_traveled>300):
		queue_free()
	if(!stuck):
		position += motion*speed*delta
		distance_traveled += speed*delta
	else:
		if(!wr.get_ref()):
			queue_free()
		else:
			position.x += head.positionnext
	pass


func _on_knife_body_entered( body ):
	if(body.is_in_group("dude")):
		speed = 0
		tdissapear.start()
		body.die()
	pass # replace with function body


func _on_Timer_timeout():
	queue_free()
	pass # replace with function body


func _on_knife_area_entered( area ):
	if(area.is_in_group("head")):
		tdissapear.start()
		stuck = true
	pass # replace with function body
