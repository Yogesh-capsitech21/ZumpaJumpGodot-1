extends Control

@onready var grid_container = $Control/GridContainer


func _ready() -> void:

	setup_level_box()


func setup_level_box():

	var level_number = 1

	for box in grid_container.get_children():

		# skip wrong nodes
		if not box.has_method("level_locked"):
			continue

		box.level_num = level_number

		# unlock only level 1
		if level_number == 1:
			box.locked = false
		else:
			box.locked = true

		# connect signal
		box.level_selected.connect(_on_level_selected)

		level_number += 1


func _on_level_selected(level_num):

	var level_path = ""

	if level_num == 1:
		level_path = "res://scenes/main_scene.tscn"

	elif level_num == 2:
		level_path = "res://levels folder/lvl_2.tscn"

	elif level_num == 3:
		level_path = "res://levels folder/lvl_3.tscn"

	get_tree().change_scene_to_file(level_path)

func _on_back_pressed() -> void:

	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_2_pressed() -> void:

	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
