extends Area2D

@export var slow_motion_scale := 0.3
@export var slow_motion_time := 5.0

@export var level_complete_panel : Control
@export var pause_panel : Control


func _on_body_entered(body):

	if body.is_in_group("player"):

		# hide pause panel if open
		if pause_panel:
			pause_panel.visible = false

		# open level complete panel
		if level_complete_panel:
			level_complete_panel.show_panel(
				GameManager.stars_collected
			)

		# slow motion effect
		Engine.time_scale = slow_motion_scale

		# wait
		await get_tree().create_timer(
			slow_motion_time * slow_motion_scale
		).timeout

		# normal speed
		Engine.time_scale = 1.0
