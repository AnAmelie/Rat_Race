extends Node

const count : int = 8

var counter : int = 0


func _ready():
	#$BG.rect_pivot_offset = $BG.rect_size / 2
	randomize()
	$Player/HUD/Control.visible = false

	#$Player/camera.current = false


func _on_StartButton_pressed():
	Global.goto_scene("res://UI/NameEntry.tscn")


func _on_SecretButton_pressed():
	pass # Replace with function body.


func _on_glitch_timer_timeout():
	$glitch_timer.wait_time = rand_range(0.001, 1)
	$BG.set_visible(true)
	if counter % count == 0:
		$BG.set_stretch_mode(2)
	elif counter % count == 1:
		$BG.set_rotation(180)
	elif counter % count == 2:
		$BG.set_rotation(90)
	elif counter % count == 3:
		$BG.set_stretch_mode(7)
	elif counter % count == 4:
		$BG.set_rotation(0)
	elif counter % count ==5:
		$BG.set_scale(Vector2(2, 2))
	elif counter % count == 6:
		$BG.set_scale(Vector2(3, 3))
	elif counter % count == 7:
		$BG.set_visible(false)
	counter += floor(rand_range(1, 3))
	


func _on_Cheese_success():
	print("success")
