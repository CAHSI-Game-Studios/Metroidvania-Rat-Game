extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var animation : AnimatedSprite2D

func _ready() -> void:
	animation.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#La direccion del sprite
	if direction < 0:
		animation.flip_h = true
	elif direction > 0:
		animation.flip_h = false

	move_and_slide()
