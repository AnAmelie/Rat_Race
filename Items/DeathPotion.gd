extends AnimatedSprite

func _ready():

	pass # Replace with function body.




func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over("The potion killed you. Game over. Try again?")
		set_visible(false)
