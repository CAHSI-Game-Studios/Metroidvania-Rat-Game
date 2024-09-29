extends CharacterBody2D

@onready var healthbar: ProgressBar = $healthbar
var speed = 35
var player_chase = false
var player = null
var direction = 1
var health = 100
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	deal_with_damage()
	
	update_health()
	
	
	if player_chase:
		velocity.x = speed * sign(player.position.x - position.x)
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) <0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = speed * direction
		if randi_range(0,150) == 1:
			change_direction()
		$AnimatedSprite2D.play("idle")
	if sign(velocity.x) == 1:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true 
	move_and_slide()

func change_direction():
	direction *= -1
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
	
func enemy():
	pass
	


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		

func deal_with_damage():
	if player_inattack_zone == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("magma health = ", health)
			if health <= 0:
				self.queue_free()



func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	
func update_health():
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
