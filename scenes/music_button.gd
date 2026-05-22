extends TextureButton

var is_on = true

@onready var on_texture = preload("res://assets/Group 425.png")
@onready var off_texture = preload("res://assets/Group 328.png")

func _ready():
	texture_normal = on_texture

func _pressed():

	is_on = !is_on

	if is_on:
		texture_normal = on_texture
	else:
		texture_normal = off_texture
