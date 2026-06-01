extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	
func _process(delta):
	rotation += 2.0 * delta
	
#  Collision
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()
