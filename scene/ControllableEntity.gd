class_name ControllableEntity
extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO

export(bool) var in_motion := false
export(float) var speed := 24000

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta: float) -> void:
	if ! in_motion:
		return
	get_input()
	velocity = move_and_slide(velocity * delta)
