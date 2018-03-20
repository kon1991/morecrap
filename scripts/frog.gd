extends Area2D

var speed = 100
var motion = Vector2(-1,0)
var dir = -1
onready var anim =$anim


func _ready():
	anim.play("walk_left")
	pass

func _process(delta):
	position += dir*motion*delta*speed
	if(abs(position.x) > 100):
		dir *= -1
		if(anim.current_animation == "walk_left"):
			anim.play("walk_right")
		elif(anim.current_animation == "walk_right"):
			anim.play("walk_left")
	pass


func _on_frog_area_entered( area ):
	if(area.is_in_group("damage")):
		$hit.play()
		area.queue_free()
		anim.play("ded")
		speed = 0
		if(dir==1):
			$Sprite.set_flip_h(true)
		$CollisionShape2D.set_disabled(true)
	pass # replace with function body
