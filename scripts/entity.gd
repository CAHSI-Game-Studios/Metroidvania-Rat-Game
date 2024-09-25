extends CharacterBody2D
class_name Entity 

@export var animation : AnimatedSprite2D
@export var speed = 30
var player_chase = false
var player = null

func _ready() -> void:
	animation.play("idle")
	
func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position) / speed
		animation.play("walk")
		
		if (player.position.x - position.x) < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		animation.play("idle")
		
# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


# si el player entra al detection area then follow the player
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

#if the player leaves the detection area then stop chasing
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
