extends CharacterBody2D

# Variables for movement
@export var speed : float = 200.0      # Horizontal speed
@export var jump_force : float = 400.0 # Jump strength
@export var gravity : float = 1000.0   # Gravity force



# Function for handling input and movement
func _physics_process(delta: float) -> void:
	# Reset horizontal velocity
	velocity.x = 0

	# Move left or right
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed

	# Check if the character is on the floor (can jump)
	if is_on_floor():
		# Jumping when pressing the jump button
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_force
	else:
		# Apply gravity if not on the floor
		velocity.y += gravity * delta

	# Move the character with move_and_slide() which handles collision and sliding
	move_and_slide()
