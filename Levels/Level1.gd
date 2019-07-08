extends Node


func _ready():
	Global.death_count = 0
	Global.game_over_text[0] = "Are you sure you're going the right way?"
	Global.game_over_text[1] = "Some walls may not be as solid as they seem..."
	Global.game_over_text[2] = "Well clearly you couldn't find the wall. There's a pause glitch too, btw."
	Global.game_over_text[3] = "Press the pause button right now and see what happens"
	
	reset()
	opening_message()


func reset():
	$Player.set_position(Vector2(31, 150))
	$Player.speed = 140
	Global.initial_countdown = 8
	Global.start()
	Global.pause_glitch = true
	Global.level = "res://Levels/Level1.tscn"
	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))




func opening_message():
	$Player/HUD/Control.show()
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Middle/Restart.hide()
	$Player/HUD/Control/Middle2/Start.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Reach the cheese before the timer runs out!"
	$Player/HUD/Control/Bottom/MessageBG.show()
	yield($Player/HUD/Control/Middle2/Start, "pressed")
	$Player/Countdown.start()


func _on_Cheese_success():
	get_tree().paused = true
	$Player/HUD/Control/Bottom/MessageBG/Message.text = Global.success_text()
	$Player/HUD/Control/Bottom/MessageBG.show()
	Global.success_time(2)
	yield(Global.success_time(2), "timeout")
	Global.goto_scene("res://Levels/Level2.tscn")
	
	"""
	if Global.countdown >= 0:
		Global.goto_scene("res://Levels/Level2.tscn")
	elif Global.countdown < 0:
		Global.goto_scene("res://Levels/Level2.tscn")"""



func _on_Player_restart():
	reset()
