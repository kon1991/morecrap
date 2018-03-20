extends Area2D

onready var label = get_parent().get_node("CanvasLayer").get_node("Label")
onready var cp = get_parent().get_node("checkpoint")
export var lines = [""]
export var customSignal = ""
export var validcp = true


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_sensor_body_entered( body ):
	if(body.is_in_group("player")):
		if(validcp):
			cp.spawnposition = position
		label.dialogue = lines
		label.customSignal = customSignal
		label.play_next_dialog()
		print("owo")
		queue_free()
	pass # replace with function body
