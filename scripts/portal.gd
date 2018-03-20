extends Area2D

onready var canvas = get_parent().get_node("CanvasLayer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_portal_body_entered( body ):
	if(body.is_in_group("player")):
		body.end()
		canvas.end()
	pass # replace with function body
