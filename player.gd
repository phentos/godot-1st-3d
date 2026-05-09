extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75

# "3d vector combining speed with direction"
var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_back"):
		direction.x += 1
	if Input.is_action_pressed("move_forward"):
		direction.x += -1
