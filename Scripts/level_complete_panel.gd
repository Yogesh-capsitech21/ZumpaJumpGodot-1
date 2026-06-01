extends Control

@onready var animation_player = $AnimationPlayer

@onready var star1 = $Star1
@onready var star2 = $Star2
@onready var star3 = $Star3

@onready var next_button = $NextButton
@onready var back_button = $BackButton


# EMPTY STARS
@export var empty_star1 : Texture2D
@export var empty_star2 : Texture2D
@export var empty_star3 : Texture2D

# FILLED STARS
@export var fill_star1 : Texture2D
@export var fill_star2 : Texture2D
@export var fill_star3 : Texture2D

# NEXT LEVEL
@export var next_level_path := "res://scenes/lvl_2.tscn"


func _ready():

	visible = false

	# default empty stars
	star1.texture = empty_star1
	star2.texture = empty_star2
	star3.texture = empty_star3


func show_panel(collected_stars):

	visible = true

	# enable buttons again
	next_button.disabled = false
	back_button.disabled = false

	# reset stars
	star1.texture = empty_star1
	star2.texture = empty_star2
	star3.texture = empty_star3

	# show collected stars
	if collected_stars >= 1:
		star1.texture = fill_star1

	if collected_stars >= 2:
		star2.texture = fill_star2

	if collected_stars >= 3:
		star3.texture = fill_star3

	# pause game
	get_tree().paused = true

func _on_next_button_pressed():

	print("NEXT BUTTON PRESSED")

	# unpause game
	get_tree().paused = false

	# reset time scale
	Engine.time_scale = 1.0

	# reset stars
	GameManager.stars_collected = 0

	# hide panel
	visible = false

	# change scene directly
	var error = get_tree().change_scene_to_file(
		next_level_path
	)

	print(error)
func _on_back_button_pressed():

	# prevent multiple taps
	back_button.disabled = true

	# unpause game
	get_tree().paused = false

	# reset slow motion
	Engine.time_scale = 1.0

	# smooth close
	visible = false

	# small delay
	await get_tree().create_timer(0.3).timeout

	# restart level
	get_tree().reload_current_scene()


func _on_win_line_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
