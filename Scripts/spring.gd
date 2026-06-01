extends Area2D

@export var spring_force := -700



func _ready():

	# connect collision
	body_entered.connect(_on_body_entered)

	# stop animation initially
	$AnimationPlayer.stop()

	# reset to first frame
	$AnimationPlayer.seek(0, true)


func _on_body_entered(body):

	# check player
	if body.is_in_group("player"):

		# bounce player upward
		body.velocity.y = spring_force

		# restart animation from beginning
		$AnimationPlayer.stop()

		$AnimationPlayer.play("new_animation")

		# wait animation finish
		await $AnimationPlayer.animation_finished

		# return to start frame
		$AnimationPlayer.seek(0, true)

		# stop animation
		$AnimationPlayer.stop()
