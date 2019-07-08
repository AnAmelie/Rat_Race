extends Sprite

signal success

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
		emit_signal("success")