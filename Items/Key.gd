extends Sprite


func _ready():
	pass # Replace with function body.


func _on_area_body_entered(body):
	if body.is_in_group("Player"):
		Global.key_obtained = true
		set_visible(false)
		#queue_free()
