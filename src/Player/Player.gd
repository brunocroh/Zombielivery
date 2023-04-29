extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

	position += delta * velocity

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

## HealthBar
func update_health():
	var healthbar = $healthbar
	var health = healthbar.value
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regintimer_timeout():
	pass # Replace with function body.


















<<<<<<< HEAD
=======

  if velocity.x < 0:
    $AnimatedSprite2D.flip_h = true
  else:
    $AnimatedSprite2D.flip_h = false

  position += delta * velocity
>>>>>>> 32c580a088a9b6be539351ac7b62456ee91e4882


