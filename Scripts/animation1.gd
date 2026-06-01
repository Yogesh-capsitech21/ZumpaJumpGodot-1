extends Area2D


@onready var sprite = $Sprite2D
@onready var target_position = $Marker2D


func _ready():

	body_entered.connect(_on_body_entered)


func _process(delta):

	# rotate portal
	sprite.rotation += 2.0 * delta


func _on_body_entered(body):

	if body.is_in_group("player"):

		# move player to second box
		body.global_position = target_position.global_position

		# optional jump effect
		body.velocity.y = -300
