extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 30

# "3d vector combining speed with direction"
var target_velocity = Vector3.ZERO
var bonk_bonus = 1

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z += -1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if is_on_floor():
		bonk_bonus = 1
		if Input.is_action_just_pressed("jump"):
			target_velocity.y = jump_impulse
	else:
		target_velocity.y = target_velocity.y - ((fall_acceleration * delta) / bonk_bonus)
	
	velocity = target_velocity
	
	move_and_slide()
	
	process_collisions()
	
func process_collisions():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)

		var mob = collision.get_collider()
		if mob:
			if mob.is_in_group("mob") and Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				bonk_bonus += 1
				target_velocity.y = bounce_impulse
				break
