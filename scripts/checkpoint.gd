extends Node2D

onready var player = get_parent().get_node("player")
var spawnposition

func _ready():
	spawnposition = player.position
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
