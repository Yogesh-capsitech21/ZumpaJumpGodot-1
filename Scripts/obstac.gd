extends Area2D

# horizontal speed
@export var move_speed := 250.0

# horizontal move range
@export var move_distance := 500.0

# vertical speed
@export var vertical_speed := 120.0

# vertical move range
@export var vertical_distance := 100.0


var start_position : Vector2

# start moving RIGHT → LEFT
var horizontal_direction := -1




@onready var sprite = $Sprite2D


func _ready():

	body_entered.connect(_on_body_entered)

	start_position = global_position


func _process(delta):

	# movement
	position.x += move_speed * horizontal_direction * delta
	#position.y += vertical_speed * vertical_direction * delta


	# FACE DIRECTION

	# moving LEFT
	if horizontal_direction < 0:
		sprite.flip_h = true

	# moving RIGHT
	else:
		sprite.flip_h = false


	# RIGHT LIMIT
	if position.x >= start_position.x + move_distance:
		horizontal_direction = -1

	# LEFT LIMIT
	elif position.x <= start_position.x - move_distance:
		horizontal_direction = 1

func _on_body_entered(body):

	if body.is_in_group("player"):
		body.die()
