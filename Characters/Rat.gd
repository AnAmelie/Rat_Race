extends Sprite

signal show_message
signal remove_message

func _ready():
	$anim.play("moving")

func _on_area_body_entered(body):
	emit_signal("show_message")

func _on_area_body_exited(body):
	emit_signal("remove_message")
