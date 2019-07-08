extends Node2D

var pos = Vector2(0,0)

func _ready():
	pass

func set_partner(node):
	pos = node.get_global_position()
	#pos = node.get_global_transform()
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.set_position(pos)


func _on_AnimatedSprite_frame_changed():
	$AnimatedSprite.set_speed_scale(rand_range(.5, 5))
