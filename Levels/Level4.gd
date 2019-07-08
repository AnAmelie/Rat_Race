extends Node

onready var follow1 = get_node("catpath1/follow")
onready var follow2 = get_node("catpath2/follow")
onready var follow3 = get_node("catpath3/follow")
onready var follow4 = get_node("catpath4/follow")
onready var follow5 = get_node("catpath5/follow")


func _ready():
	#level specific info
	$Teleporter1.set_partner($loc1)
	$Teleporter2.set_partner($loc2)
	$Teleporter3.set_partner($loc3)
	$Teleporter4.set_partner($loc4)
	
	Global.game_over_text[0] = "Hint: Don't get eaten by the cat"
	Global.game_over_text[1] = "There are several glitches in this level:"
	Global.game_over_text[2] = "Fake walls, teleporters, you name it!"
	Global.game_over_text[3] = "Try the top right corner of the maze"
	
	set_process(true)
	var cat_array = get_tree().get_nodes_in_group("cat")
	for i in cat_array:
		i.play_moving()
		
	#every level gets this
	Global.death_count = 0
	reset()
	opening_message()

		

func _process(delta):
	follow1.set_offset(follow1.get_offset() + 20 * delta) 
	follow2.set_offset(follow2.get_offset() + 30 * delta)
	follow3.set_offset(follow3.get_offset() + 20 * delta) 
	follow4.set_offset(follow4.get_offset() + 30 * delta)
	follow5.set_offset(follow5.get_offset() + 20 * delta) 

func opening_message():
	$Player/HUD/Control.show()
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Middle/Restart.hide()
	$Player/HUD/Control/Middle2/Start.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Avoid the cats! Get the cheese!"
	$Player/HUD/Control/Bottom/MessageBG.show()
	#$Player/HUD._on_PauseButton_pressed()
	$Player/Countdown.start()
	
	
func reset():
	$Player.set_position(Vector2(-20, 40))
	$Player.speed = 140
	Global.initial_countdown = 100
	Global.start()
	Global.pause_glitch = false
	Global.level = "res://Levels/Level4.tscn"
	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))

		
func _on_Cheese_success():
	get_tree().paused = true
	$Player/HUD/Control/Bottom/MessageBG/Message.text = Global.success_text()
	$Player/HUD/Control/Bottom/MessageBG.show()
	Global.success_time(2)
	yield(Global.success_time(2), "timeout")
	Global.goto_scene("res://Levels/LevelFin.tscn")


func _on_Player_restart():
	reset()
	
