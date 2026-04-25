extends CharacterBody2D

var block = 16
var SPEED = block * 10
var JUMP_VELOCITY = block * -20
var nbr_saut = 0
var dash_lenght = 600
var dashing = false
var dash_time_left = 0.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("walk_left", "walk_right")
	if not is_on_floor() and dashing == false:
		velocity += get_gravity() * delta
		$AnimatedSprite2D.play("jump")
	#else: 
		#velocity.y += get_gravity().y * 0.2 * delta
	
	if is_on_floor():
		nbr_saut = 0
		
	if Input.is_action_just_pressed("jump") and nbr_saut <= 1:
		nbr_saut += 1 
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("dash"):
		dashing = true
		dash_time_left = 0.15
		
	if dashing:
		dash(direction)
		dash_time_left -= delta
		if dash_time_left <= 0:
			dashing = false
	else:
		velocity.x = direction * SPEED
		walk(direction)
		
	update_animation(direction)
	$Camera2D.position.y = -50
	move_and_slide()
 
func walk(direction): 
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0: 
		$AnimatedSprite2D.flip_h = true
	
	
func dash(direction): 
	if direction != 0:
		if direction > 0:
			$AnimatedSprite2D.flip_h = false
			velocity.x = direction * SPEED + dash_lenght
		elif direction < 0: 
			$AnimatedSprite2D.flip_h = true
			velocity.x = direction * SPEED - dash_lenght 
	
	
func update_animation(direction):
	if dashing and direction != 0:
		$AnimatedSprite2D.play("dash")
	elif not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif direction == 0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")

func spawn_player(marker):
	
	print("Position Marker: ", marker.global_position)
	global_position = marker.global_position
	reset_physics_interpolation()
	print("Position Player après spawn: ", global_position)

func die(marker):
	spawn_player(marker)
