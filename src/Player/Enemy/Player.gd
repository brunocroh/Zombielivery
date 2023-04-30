extends Area2D

@export var speed = 400 
var screen_size 
var healthPlayer = 100

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	player_movement(delta)
	update_health()

func player_movement(delta):
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	position += delta * velocity

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

## HealthBar
func update_health():
	var healthbar = $ProgressBar
	healthbar.value = healthPlayer
	
	if healthPlayer >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regin_timer_timeout():
	if healthPlayer < 100:
		healthPlayer = healthPlayer + 20
		if healthPlayer > 100:
			healthPlayer = 100
		if healthPlayer == 0:
			healthPlayer = 0


func _on_area_entered(area):
	healthPlayer = healthPlayer - 20
