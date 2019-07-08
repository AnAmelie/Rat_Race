extends Node

func _ready():
	#level specific settings
	$Teleporter1.set_partner($loc1)
	$Teleporter2.set_partner($loc2)
	$Teleporter3.set_partner($loc3)
	$Teleporter4.set_partner($loc4)
	$Teleporter5.set_partner($loc5)
	$Teleporter6.set_partner($loc6)
	$Teleporter7.set_partner($loc7)
	$cat/anim.play("moving")
	
	Global.game_over_text[0] = "Hmm. Maybe you should try going a different way"
	Global.game_over_text[1] = ""
	Global.game_over_text[2] = ""
	Global.game_over_text[3] = ""

	#non-level specific
	Global.death_count = 0
	reset()
	opening_message()

	
	
func opening_message():
	$Player/HUD/Control.show()
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Middle/Restart.hide()
	$Player/HUD/Control/Middle2/Start.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Exploit the glitches to get to the cheese!"
	$Player/HUD/Control/Bottom/MessageBG.show()
	#$Player/HUD._on_PauseButton_pressed()
	$Player/Countdown.start()

func reset():
	$Player.set_position(Vector2(294, 290))
	$Player.speed = 100
	Global.initial_countdown = 50
	Global.start()
	Global.pause_glitch = false
	Global.level = "res://Levels/Level2.tscn"
	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))

		
	

func _on_Cheese_success():
	get_tree().paused = true
	$Player/HUD/Control/Bottom/MessageBG/Message.text = Global.success_text()
	$Player/HUD/Control/Bottom/MessageBG.show()
	Global.success_time(2)
	yield(Global.success_time(2), "timeout")
	Global.goto_scene("res://Levels/Level3.tscn")


func _on_Player_restart():
	reset()
