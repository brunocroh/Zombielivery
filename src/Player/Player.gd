extends CharacterBody2D

@export var speed = 400 
var screen_size 
var healthPlayer = 100
var currentDamage = 2
@onready var bulletPath = preload("res://src/bullet/bullet.tscn")
var can_fire = true


func _ready():
	screen_size = get_viewport_rect().size
	add_to_group(GlobalScript.grupoPlayer)

func _process(delta):
	player_movement(delta)
	update_health()
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()
		
	$weapon.look_at(get_global_mouse_position())

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

	position.x = position.x
	position.y = position.y

## HealthBar
func damage_take(damage):
	healthPlayer -= damage
	print('health', healthPlayer)
	update_health()

func update_health():
	var healthbar = $ProgressBar
	healthbar.value = healthPlayer
	
	if healthPlayer >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regin_timer_timeout():
	if healthPlayer < 20:
		healthPlayer = healthPlayer + 1
		if healthPlayer > 20:
			healthPlayer = 20
		if healthPlayer == 0:
			healthPlayer = 0

func _on_area_entered(area):
	if area.is_in_group(GlobalScript.grupoInimigo):
		GlobalScript.damageTake()
		healthPlayer = GlobalScript.healthGlobalPlayer
	
func shoot():
	var bullet = bulletPath.instantiate()
	bullet.position = $weapon/Marker2D.global_position
	bullet.veloc = get_global_mouse_position() - bullet.position
	get_parent().add_child(bullet)
	can_fire = false
	await get_tree().create_timer(0.3).timeout
	can_fire = true
