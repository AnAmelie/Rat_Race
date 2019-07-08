extends Node

func _ready():
	get_tree().paused = false


func _on_cheese_pressed():
	Global.goto_scene("res://UI/TitleScreen.tscn")
