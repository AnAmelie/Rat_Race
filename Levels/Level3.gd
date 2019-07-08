extends Node

export (PackedScene) var Cheese

var LocArray : Array = []
var cheese_loc = 0

func _ready():
	
	#level specific info
	Global.game_over_text[0] = "Hmm. Maybe you should try going a different way"
	Global.game_over_text[1] = "Cheese location depends on your name"
	Global.game_over_text[2] = "Name -> ASCII -> %62 -> cheese location"
	Global.game_over_text[3] = ""
	
	var name_array = Global.player_name.to_ascii()
	
	for i in name_array:
		cheese_loc += i
	cheese_loc = cheese_loc % 62
	
	#spawn the massive number of cheeses:
	for i in range(8):
		for j in range(8):
			LocArray.append($topleft.position + Vector2(i * 64,j * 64))
	LocArray.remove(0)
	LocArray.remove(7)
	
	
	
	#every level gets this
	Global.death_count = 0
	reset()
	opening_message()

	
func opening_message():
	$Player/HUD/Control.show()
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Middle/Restart.hide()
	$Player/HUD/Control/Middle2/Start.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Find the right cheese! Blue potions give you speed!"
	$Player/HUD/Control/Bottom/MessageBG.show()
	#$Player/HUD._on_PauseButton_pressed()
	$Player/Countdown.start()

func reset():
	$Potion.set_visible(true)
	spawn_all_the_cheeses(LocArray)
	$Cheese.set_position(LocArray[cheese_loc])
	$Player.set_position(Vector2(37, 38))
	$Player.speed = 100
	Global.initial_countdown = 50
	Global.start()
	Global.pause_glitch = false
	Global.level = "res://Levels/Level3.tscn"
	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))


func cheese_spawn(pos):
	var new_cheese = Cheese.instance()
	add_child(new_cheese)
	new_cheese.position = pos
	#pass

func spawn_all_the_cheeses(positions):
	for i in positions:
		cheese_spawn(i)
		

func _on_Cheese_success():
	get_tree().paused = true
	$Player/HUD/Control/Bottom/MessageBG/Message.text = Global.success_text()
	$Player/HUD/Control/Bottom/MessageBG.show()
	Global.success_time(2)
	yield(Global.success_time(2), "timeout")
	Global.goto_scene("res://Levels/Level4.tscn")


func _on_Player_restart():
	reset()
