extends Area2D

# horizontal speed
@export var move_speed := 250.0

# move range
@export var move_distance := 500.0

# up-down speed
@export var vertical_speed := 120.0

# up-down range
@export var vertical_distance := 100.0


var start_position : Vector2

var horizontal_direction := 1
var vertical_direction := 1


func _ready():

	body_entered.connect(_on_body_entered)

	start_position = global_position


func _process(delta):

	# LEFT ↔ RIGHT movement
	position.x += move_speed * horizontal_direction * delta

	# UP ↕ DOWN movement
	position.y += vertical_speed * vertical_direction * delta


	# RIGHT LIMIT
	if position.x >= start_position.x + move_distance:
		horizontal_direction = -1

	# LEFT LIMIT
	elif position.x <= start_position.x - move_distance:
		horizontal_direction = 1


	# DOWN LIMIT
	if position.y >= start_position.y + vertical_distance:
		vertical_direction = -1

	# UP LIMIT
	elif position.y <= start_position.y - vertical_distance:
		vertical_direction = 1


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()
