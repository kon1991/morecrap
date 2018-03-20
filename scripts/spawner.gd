extends Node2D
onready var player = get_parent().get_node("player")
onready var tspawn = $Timer
var ghost = preload("res://scenes/evghost.tscn")
export var spawn_number = 3
export var distance = 100
var ghostref = null
var canSpawn = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if(ghostref!=null):
		if(!ghostref.get_ref()):
			canSpawn = true
	
	if(player.position.distance_to(position)<distance && canSpawn):
		if(spawn_number>0):
			spawn()
			print("start")
	pass

func spawn():
	var newghost = ghost.instance()
	newghost.position = position
	ghostref = weakref(newghost)
	spawn_number -= 1
	get_parent().add_child(newghost)
	canSpawn = false
	pass

func _on_Timer_timeout():
	tspawn.stop()
	spawn()
	print("ednd")
	pass # replace with function body
