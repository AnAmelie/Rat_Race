extends Node


func _ready():
	#get_tree().paused = true
	Global.death_count = 0
	Global.game_over_text[0] = "Umm... I don't know what to say. Get the cheese. Faster."
	Global.game_over_text[1] = "Why are you spending so much time on the tutorial level?"
	Global.game_over_text[2] = "Why? Why are you doing this?"
	Global.game_over_text[3] = "?"
	reset()
	
	opening_message()

	
	#print(Global.countdown)
	
func reset():
	$Player.set_position(Vector2(37, 151))
	Global.initial_countdown = 50
	Global.start()
	Global.pause_glitch = false
	Global.level = "res://Levels/Level0.tscn"

	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))
	
func opening_message():
	$Player/HUD/Control.show()
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Middle/Restart.hide()
	$Player/HUD/Control/Middle2/Start.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Reach the cheese before the timer runs out!"
	$Player/HUD._on_PauseButton_pressed()
	$Player/Countdown.start()

func _on_Cheese_success():
	#Do something on the HUD so the player has a smooth transition to the next level
	get_tree().paused = true
	$Player/HUD/Control/Bottom/MessageBG/Message.text = Global.success_text()
	$Player/HUD/Control/Bottom/MessageBG.show()
	Global.success_time(2)
	yield(Global.success_time(2), "timeout")
	Global.goto_scene("res://Levels/Level1.tscn")



func _on_Player_restart():
	reset()
