extends Node

var anim_array = ["red", "green", "yellow"]

onready var next = $Player/HUD/Control/Bottom/MessageBG/NextButton

func _ready():
	Global.death_count = 0
	reset()
	opening_message()

func reset():
	$Player.set_position(Vector2(422, 43))
	$Player.speed = 140
	Global.initial_countdown = 50
	Global.start()
	Global.pause_glitch = false
	Global.level = "res://Levels/GiantDrink.tscn"
	$Player/HUD/Control/Top/TopBar/Countdown.text = (str(Global.countdown))
	
	#give the death potions random colors
	var int1 = floor(rand_range(0, 2.9))
	var int2 = floor(rand_range(0, 2.9))
	$DeathPotion.play(anim_array[int1])
	$DeathPotion.play(anim_array[int2])
	$DeathPotion.set_visible(true)
	$DeathPotion2.set_visible(true)

func opening_message():
	$Player/HUD/Control.show()
	$Player/HUD/Control/Middle2/Start.hide()
	$Player/HUD/Control/blackout.hide()
	$Player/HUD/Control/Middle/Restart.hide()
	
	$Player/HUD/Control/Bottom/MessageBG.show()
	next.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Ho hee ho hee... You think you can escape?"
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "I'll tell you what! Let's make a deal."
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Pfff ho hee... Drink one of these potions:"
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Choose correctly, and I let you and your friends go."
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Choose incorrectly, and I'll be taking a trip to the pet store..."
	yield(next, "pressed")
	
	
	
	#$Player/HUD._on_PauseButton_pressed()
	$Player/HUD/Control/Middle2/Start.show()
	yield($Player/HUD/Control/Middle2/Start, "pressed")
	$Player/Countdown.start()


func _on_area_body_entered(body):
	if body.is_in_group("Player"):
		win()
		
func win():
	get_tree().paused = true
	#Global.success_time(4)
	#yield(Global.success_time(4), "timeout")
	$Player/HUD/Control/Bottom/MessageBG.show()
	next.show()
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "AAAAAAahhhhh!!!!"
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "It's eating my faaaacee!!!!"
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Cats!!! Save me!!!!!"
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = ".........."
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "Ooooohhhhh nooooooooo!!!...."
	yield(next, "pressed")
	$Player/HUD/Control/Bottom/MessageBG/Message.text = "........................."
	yield(next, "pressed")
	Global.goto_scene("res://Levels/EndScene.tscn")

func _on_Player_restart():
	reset() 
