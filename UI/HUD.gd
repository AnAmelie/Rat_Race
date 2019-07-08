extends CanvasLayer
signal restart

func _ready():
	$Control/Bottom/MessageBG.show()

func _on_PauseButton_pressed():
	if get_tree().paused == true:
		#unpause. hide message
		$Control/Bottom/MessageBG.hide()
		get_tree().paused = false
		
	elif get_tree().paused == false: 
		#pause, show message
		$Control/Bottom/MessageBG.show()
		get_tree().paused = true
		

func _on_Restart_pressed():
	#Global.goto_scene(Global.level)
	#get_node(Global.level).reset()
	emit_signal("restart")
	$Control/Middle/Restart.hide()
	get_tree().paused = false


func _on_Start_pressed():
	get_tree().paused = false
	$Control/Middle2.hide()
	$Control/Bottom/MessageBG.hide()


