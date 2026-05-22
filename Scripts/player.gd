extends CharacterBody2D

var stars_collected := 0

@export var speed := 200
@export var jump_force := -400
@export var gravity := 900

var is_dead := false

var spring = -600


func _ready():

	add_to_group("player")

	GameManager.stars_collected = 0


func _physics_process(delta):

	# stop movement if dead
	if is_dead:
		return

	# gravity
	velocity.y += gravity * delta

	# movement
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

	# collision check
	for i in range(get_slide_collision_count()):

		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider and collider.is_in_group("obstacle"):
			die()


func collect_star():

	stars_collected += 1

	GameManager.stars_collected = stars_collected

	print("Stars Collected: ", stars_collected)


func win_level():

	print("LEVEL COMPLETE")


func die():

	if is_dead:
		return

	is_dead = true

	GameManager.stars_collected = 0

	get_tree().paused = false

	await get_tree().process_frame

	get_tree().change_scene_to_file(
		"res://scenes/main_scene.tscn"
	)
func _on_spring_body_entered(body: Node2D) -> void:

	velocity.y = spring
