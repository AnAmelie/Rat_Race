extends Node2D

signal opened

func _ready():
	pass # Replace with function body.



func _on_area_body_entered(body):
	if body.is_in_group("Player") and Global.key_obtained:
		$Sprite.queue_free()
		emit_signal("opened")