extends Area2D

onready var label2 = get_parent().get_node("CanvasLayer").get_node("Label2")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_knife_body_entered( body ):
	if(body.is_in_group("player")):
		$knife.play()
		body.canKnife = true
		body.hasKnife = true
		label2.show()
		queue_free()
	pass # replace with function body
