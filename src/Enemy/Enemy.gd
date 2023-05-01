extends CharacterBody2D

var target 
var SPEED = 500

var health = GlobalScript.healthBasicEnemy
signal health_depleted
signal enemy_attack

func _ready():
	add_to_group(GlobalScript.grupoInimigo)


func _physics_process(delta):
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
