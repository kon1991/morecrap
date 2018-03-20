extends Area2D

onready var player = get_node("../player")
const SPEED = 10
var pursuing = false

func _ready():
	add_to_group("ghost")
	pass

func _process(delta):
	if(!pursuing):
		if(position.distance_to(player.position) <= 200):
			pursuing = true
	else:
		var dir = player.position - position
		dir = dir.normalized()
		position += dir*SPEED*delta
	pass





func _on_evghost_area_entered( area ):
	if(area.is_in_group("damage")):
		$hit.play()
		area.queue_free()
		queue_free()
	pass # replace with function body


func _on_evghost_body_entered( body ):
	if(body.is_in_group("player")):
		body.hit()
	pass # replace with function body
