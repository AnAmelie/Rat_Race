extends KinematicBody2D
signal restart

var speed = Global.speed 
var movedir = Vector2(0,0)
var spritedir = "down"
var is_moving : bool = false
var LEFT: bool = false
var RIGHT: bool = false
var UP: bool = false
var DOWN: bool = false

var timer = Timer.new()



func _ready():
	#correct the player's speed depending on what his scale is
	speed *= scale.x
	#$HUD/Control/Bottom/MessageBG.hide()
	


func _physics_process(delta):
	#check to see if the user wants to talk to a character
	#NOTE: RAY DOES NOT LIKE THE TELEPORTER AREA NODE. I THINK.
	#if character is facing the talker, the object is in the talker group, and the user presses accept
	if $ray.is_colliding() and $ray.get_collider().is_in_group("talker") and Input.is_action_just_released("ui_accept"):
		#print("talking to " + str($ray.get_collider()))
		talk_to($ray.get_collider())
		
	if get_tree().paused:
		print("paused")
		
	controls_loop()
	movement_loop()
	spritedir_loop()

	if is_on_wall(): #maybe add pushing here later:
		pass
		"""
		if spritedir == "left" and test_move(transform, Vector2(-1, 0)) and LEFT:
			anim_switch("push")
		elif spritedir == "right" and test_move(transform, Vector2(1, 0)) and RIGHT:
			anim_switch("push")
		elif spritedir == "down" and test_move(transform, Vector2(0,1)) and DOWN:
			anim_switch("push")
		elif spritedir == "up" and test_move(transform, Vector2(0, -1)) and UP:
			anim_switch("push")
		else:
			anim_switch("idle")
			"""
	elif movedir != Vector2(0,0):
		anim_switch("moving")
	else:
		anim_switch("idle")
	
#this function controls the movement direction of the character
func controls_loop():
	LEFT = Input.is_action_pressed("ui_left")
	RIGHT = Input.is_action_pressed("ui_right")
	UP = Input.is_action_pressed("ui_up")
	DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
#this function controls the speed and movement of the player
func movement_loop():
	var motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2(0,0))

#this controls the direction of the player's sprite
func spritedir_loop():
	match movedir:
		Vector2(-1, 0):
			spritedir = "left"
			$ray.rotation_degrees = 90
			$Sprite.rotation_degrees = 270
		Vector2(1, 0):
			spritedir = "right"
			$ray.rotation_degrees = 270
			$Sprite.rotation_degrees = 90
		Vector2(0, -1):
			spritedir = "up"
			$ray.rotation_degrees = 180
			$Sprite.rotation_degrees = 0
		Vector2(0, 1):
			spritedir = "down"
			$ray.rotation_degrees = 0
			$Sprite.rotation_degrees = 180
			
#this function controls the animation of the player's sprite 
func anim_switch(animation):
	#var newanim = str(animation, "_", spritedir)
	var newanim = str(animation)
	if $anim.current_animation != newanim:
		$anim.play(newanim)
		
#this function is initiated when the player talks to a "talker"
func talk_to(talker):
	#pause the scene first, setting the textbox to visible
	get_tree().paused = true
	$TextBox/Control.set_visible(true)
	
	#next, for each string in the Dialogue array in the talker node, display in the textbox
	for i in talker.Dialogue:
		$TextBox/Control/TextureRect/Label.set_text(i)
		#do not show the next string until the user presses the button or hits accept
		yield($TextBox/Control/TextureRect/NextButton, "pressed")
		
	#When there are no more strings in Dialogue, take away the textbox and unpause the scene
	$TextBox/Control.set_visible(false)
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().paused = false

#Teleporter for the player
func _on_Teleporter_area_entered(area):
	if area.is_in_group("teleporter"):
		#get the teleporter's partner node
		var spawn_node = area.get_partner()
		var parent = spawn_node.get_parent()
		set_position(parent.get_position() + parent.get_spawn_loc())


func _on_Countdown_timeout():
	Global.count_one()
	$HUD/Control/Top/TopBar/Countdown.text = str(Global.countdown)
	if Global.countdown <= 0:
		game_over(str(Global.get_game_over_text()))
	""" #one day...
	elif Global.countdown == -666:
		Global.goto_scene("res://Levels/DevilScene.tscn")"""
		
func game_over(game_over_text):
	Global.death_count += 1
	get_tree().paused = true
	$HUD/Control/Bottom/MessageBG/Message.text = str(game_over_text)
	$HUD/Control/Bottom/MessageBG.show()
	$HUD/Control/Middle/Restart.show()
	$HUD/Control/Top/TopBar/PauseButton.set_disabled(!Global.pause_glitch)
	#queue_free()


func _on_HUD_restart():
	emit_signal("restart")
	$HUD/Control/Top/TopBar/PauseButton.set_disabled(false)
	$HUD/Control/Bottom/MessageBG.hide()
