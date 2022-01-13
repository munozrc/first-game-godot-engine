extends KinematicBody2D

export(int) var max_speed = 80
export(int) var acceleration = 500
export(int) var friction = 500

var motion = Vector2.ZERO

func _physics_process(delta):
	var input = Vector2.ZERO
	
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		motion = motion.move_toward(input * max_speed, acceleration * delta)
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", motion)
		$AnimationTree.set("parameters/Walk/blend_position", motion)
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
		motion = motion.move_toward(Vector2.ZERO, friction * delta)
	
	motion = move_and_slide(motion)

