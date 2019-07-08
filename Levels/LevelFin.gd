extends Node
var evil_anim : bool = false
onready var follow1 = get_node("EvilPath/follow")

func _ready():
	$Teleporter1.set_partner($loc1)
	
	
	#every level gets this
	Global.death_count = 0
	reset()
	opening_message()



func opening_message():
	$Player/HUD/Control.set_visible(true)
	$Player/HUD/Control/blackout.show()
	$Player/HUD/Control/Middle/Restart.hide()
	$Player/HUD/Control/Middle2/Start.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = ".........................."
	$Player/HUD/Control/Bottom/MessageBG.show()
	#$Player/HUD._on_PauseButton_pressed()
	$Player/Countdown.start()
	
	
func reset():
	$Key.set_visible(true)
	$Player.set_position(Vector2(37, 38))
	$Player.speed = 140
	Global.initial_countdown = 100
	Global.start()
	Global.pause_glitch = false
	Global.level = "res://Levels/LevelFin.tscn"
	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))

func _on_Rat_show_message():
	print("debug")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Please help me! I want out of this hell!"
	$Player/HUD/Control/Bottom/MessageBG.show()


func _on_Rat2_show_message():
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "fInDcHeeSe...gEtOuT...hAAAAlP...cHeeZe..."
	$Player/HUD/Control/Bottom/MessageBG.show()


func _on_Rat3_show_message():
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Find a key, unlock this door! I'm begging you!"
	$Player/HUD/Control/Bottom/MessageBG.show()


func _on_Rat_remove_message():
	$Player/HUD/Control/Bottom/MessageBG.hide()

func _process(delta):
	if evil_anim:
		$Player/Countdown.stop()
		follow1.set_unit_offset(follow1.get_unit_offset() + .2 * delta) 
		#print_debug(follow1.get_unit_offset())
		if $EvilPath/follow.unit_offset >= 1.0:
			evil_anim = false
			finish_level()
			
	
func _on_LockedDoor_opened():
	evil_anim = true
	
func finish_level():
	get_tree().paused = true
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "He Ho Moo Hoo Ha Ha...."
	$Player/HUD/Control/Bottom/MessageBG.show()
	Global.success_time(4)
	yield(Global.success_time(4), "timeout")
	Global.goto_scene("res://Levels/GiantDrink.tscn")
	
	
	
