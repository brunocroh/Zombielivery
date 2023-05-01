extends CharacterBody2D

var target 
@export var SPEED = 500

var health = 100
signal health_depleted
signal enemy_attack

func _ready():
	update_health()
	add_to_group(GlobalScript.grupoInimigo)

func _physics_process(delta):
	update_health()
	if target:
		var _velocity = global_position.direction_to(target.position)
		move_and_collide(_velocity * SPEED * delta)

func _on_area_2d_body_entered(body):
	print(body.name)
	if body.name == "Player":
		target = body

func _on_area_2d_body_exited(body):
	print(body.name)
	if body.name == "Player":
		target = null

func _on_attack_range_body_entered(body):
	if body.name == "Player":
		enemy_attack.emit(2)

func update_health():
	var healthbar = $EnemyHealth
	healthbar.value = health

	if health <= 0:
		health_depleted.emit()
		self.queue_free()

	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
