extends Label

#onready var dialogue = $dialogue1.lines
onready var dialogue = [""]
onready var player = get_parent().get_parent().get_node("player")
signal ready
signal trap
var i = 1
var customSignal = null

func _ready():
	pass

func _input(event):
	if(event.is_action_released("ui_select") && visible_characters<get_total_character_count()):
		visible_characters = get_total_character_count()
	elif(event.is_action_released("ui_select") && visible_characters==get_total_character_count()):
		if(i<dialogue.size()):
			$voice.play()
			set_text(dialogue[i])
			visible_characters = 0
			i += 1
		else:
			set_text("")
			if(!player.canMove2):
				player.get_next_ability()
			player.canMove2 = true
			if(player.hasKnife):
				player.canKnife = true
			if(customSignal!=null):
				emit_signal(customSignal)
				customSignal = null
	pass
	
func add_char():
	if(get_total_character_count() != visible_characters):
		visible_characters += 1
	pass

func play_next_dialog():
	i=0
	set_text(dialogue[i])
#	$voice.play()
	i+=1
	visible_characters=0
	player.canMove2 = false
	if(player.hasKnife):
		player.canKnife = false
	pass

func _on_Timer_timeout():
	add_char()
	pass 
