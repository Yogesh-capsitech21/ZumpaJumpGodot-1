extends CharacterBody2D

@export var gravity = 1000
@export var jump_force = -500
@export var move_speed = 200

# wall bounce force
@export var wall_bounce_force = 350
@export var wall_bounce_jump = 0.6

var stars_collected := 0
var direction = 0
var start_direction = 0

var current_anim = ""
var animation_locked = false

# respawn
var spawn_position: Vector2
var is_dead = false

var spring = -600


func _ready():

	add_to_group("player")

	# save spawn position
	spawn_position = global_position
	start_direction = direction

	# camera smoothing
	$Camera2D.position_smoothing_enabled = true
	$Camera2D.position_smoothing_speed = 1.0

	# hide splash at start
	$SplashSprite.visible = false


func _physics_process(delta):

	# stop movement if dead
	if is_dead:
		return

	# gravity
	velocity.y += gravity * delta

	# smooth movement
	velocity.x = move_toward(
		velocity.x,
		direction * move_speed,
		800 * delta
	)

	move_and_slide()

	# auto jump
	if is_on_floor() and velocity.y >= 0:
		velocity.y = jump_force

	# COLLISION CHECK
	for i in range(get_slide_collision_count()):

		var collision = get_slide_collision(i)

		var collider = collision.get_collider()

		if collider == null:
			continue

		# obstacle collision
		if collider.is_in_group("obstacle"):

			die()

		# LEFT WALL
		elif collider.is_in_group("left_wall"):

			direction = 1

			# bounce right
			velocity.x = wall_bounce_force

			# small upward bounce
			velocity.y = jump_force * wall_bounce_jump

		# RIGHT WALL
		elif collider.is_in_group("right_wall"):

			direction = -1

			# bounce left
			velocity.x = -wall_bounce_force

			# small upward bounce
			velocity.y = jump_force * wall_bounce_jump

	# animations
	if not animation_locked:
		update_animation()


func collect_star():

	stars_collected += 1

	print("Stars Collected: ", stars_collected)

	
	#if stars_collected >= 3:
		#win_level()

# TOUCH INPUT

func _input(event):

	if is_dead:
		return

	if event is InputEventScreenTouch and event.pressed:

		var screen_width = get_viewport_rect().size.x

		if event.position.x < screen_width / 2:
			direction = -1
			play_run_with_delay("run_left")
		else:
			direction = 1
			play_run_with_delay("run_right")

		velocity.y = jump_force


# RUN ANIMATION WITH DELAY

func play_run_with_delay(anim_name):

	animation_locked = true
	play_anim(anim_name)

	await get_tree().create_timer(1.0).timeout

	animation_locked = false


# ANIMATION LOGIC

func update_animation():

	if is_on_floor():

		if direction < 0:
			play_anim("run_left")
		else:
			play_anim("run_right")

	else:

		if velocity.y < 0:
			play_anim("jump_up")
		else:
			play_anim("fall_down")


# SAFE PLAY

func play_anim(anim_name):

	if current_anim != anim_name:
		current_anim = anim_name
		$AnimatedSprite2D.play(anim_name)


# PLAYER DIE

func die():

	if is_dead:
		return

	is_dead = true

	print("PLAYER DIED")

	# stop movement
	velocity = Vector2.ZERO

	# hide player
	$AnimatedSprite2D.visible = false

	# show splash
	$SplashSprite.visible = true

	# random splash rotation
	$SplashSprite.rotation = randf_range(0, 6.28)

	# wait before respawn
	await get_tree().create_timer(0.5).timeout

	respawn()


# RESPAWN PLAYER

func respawn():

	var camera = $Camera2D

	# disable smoothing temporarily
	camera.position_smoothing_enabled = false

	# move player to spawn position
	global_position = spawn_position

	# reset movement
	velocity = Vector2.ZERO
	direction = start_direction

	current_anim = ""
	animation_locked = false

	# hide splash
	$SplashSprite.visible = false

	# show player again
	$AnimatedSprite2D.visible = true

	is_dead = false

	# play respawn animation
	play_anim("jump_up")

	# enable camera smoothing again
	await get_tree().create_timer(0.2).timeout

	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 1.0


func _on_spring_body_entered(body: Node2D) -> void:
	velocity.y = spring


func _on_star_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
