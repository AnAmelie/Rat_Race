extends Sprite

func _ready():
	$anim.play("moving")



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over("Eaten by the cat. Game over. Try again?")

func play_moving():
	$anim.play("moving")