extends Area2D

@export var speed := 300

var start_position : Vector2


func _ready():

	# save ORIGINAL position
	start_position = global_position


func _physics_process(delta):

	# move right
	global_position.x += speed * delta


func _on_hitbox_area_entered(area):

	if area.is_in_group("right_trigger"):

		respawn_obstacle()


func respawn_obstacle():

	# stop obstacle
	set_physics_process(false)

	# hide obstacle
	visible = false

	# wait
	await get_tree().create_timer(0.5).timeout

	# move to ORIGINAL position
	global_position = start_position

	# show again
	visible = true

	# move again
	set_physics_process(true)
