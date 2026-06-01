extends Area2D

# rotation speed
@export var rotation_speed := 180.0

# random spawn amount
@export var obstacle_count := 7

# spawn area width
@export var spawn_width := 1058.0

# spawn area height
@export var spawn_height := 2890.0


func _ready():

	body_entered.connect(_on_body_entered)

	# smooth random rotation
	randomize()

	# random spawn position
	global_position = Vector2(
		randf_range(0, spawn_width),
		randf_range(0, spawn_height)
	)


func _process(delta):

	# smooth 360 rotation
	rotation_degrees += rotation_speed * delta

	# pixel perfect
	global_position = global_position.round()


# collision
func _on_body_entered(body):

	if body.is_in_group("player"):
		body.die()
