extends Area2D

onready var player = get_parent().get_node("player")
onready var difx 
var type = false
const SPEEDX =0.7
const SPEEDY =100
var distance_traveled = 0
var speedx

func _ready():
	difx = position.x - player.position.x
	
	pass
	
func init(ntype, i):
	type = ntype
	speedx = -100 + 50*i
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	if(distance_traveled>300):
		queue_free()
	if(!type):
		position.x += -1*difx*SPEEDX*delta
		position.y += SPEEDY*delta
		distance_traveled += SPEEDY*delta
	else:
		position += Vector2(speedx,SPEEDY)*delta
		distance_traveled += SPEEDY*delta
	pass


func _on_fireball_body_entered( body ):
	if(body.is_in_group("player")):
		body.hit()
	pass # replace with function body
