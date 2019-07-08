extends Node

var current_scene = null
var level = null
var death_count : int = 0
#by default, don't do the pause glitch
var pause_glitch : bool = false 
var player_name : String = "AAA"
var key_obtained : bool = false
var game_over_text : Array = ["You have failed to achieve the objective. Try again?", "Try again?", "Try again?", "Try again?"]


var initial_countdown : int 
var countdown : int

var speed = 140

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

	
func count_one():
	countdown -= 1
	
	if countdown == 0:
		pass#gameover

func start():
	countdown = initial_countdown
	
func get_game_over_text():
	if death_count < 2:
		return game_over_text[0]
	elif death_count < 5:
		return game_over_text[1]
	elif death_count < 10:
		return game_over_text[2]
	else:
		return game_over_text[3]
	
	
#READ THIS!!!!!!!!!!!!!
#Project, Project Settings, Autoload tab, add this script
#so that it will be loaded upon running ANY scene in the project

func success_text():
	var text_int = floor(rand_range(0, 4.9))
	var success_array = ["Success!", "You're awesome!", "Goal accomplished!", "Stellar work!", "Nice job!"]
	return success_array[text_int]

func success_time(time):
	var timer = Timer.new()
	timer.set_one_shot(true)
	#timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	timer.set_wait_time(time)
	timer.connect("timeout", self, "on_timeout")
	timer.set_pause_mode(time)
	timer.start()
	add_child(timer)
	return timer
	#yield(timer, "timeout")
	
#function for changing the scene. 
#we don't delete the current scene yet because it may still be executing
#code which will result in crash/etc.
#So we defer the load to a later time, when sure that no code
#from current scene is running
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	#It's safe to remove the current scene
	current_scene.free()
	#load new scene
	var s = ResourceLoader.load(path)
	#instance the new scene
	current_scene = s.instance()
	#add it to active scene as a child of root
	get_tree().get_root().add_child(current_scene)
	#optional: make it compatible with SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)

