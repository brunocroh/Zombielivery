extends Area2D

var health = GlobalScript.healthBasicEnemy

signal health_depleted

func _ready():
	add_to_group(GlobalScript.grupoInimigo)
	

func _process(delta):
	var health = GlobalScript.healthBasicEnemy
	var helthbar = $EnemyHealth
	helthbar.value = health
	if health < 1:
		health_depleted.emit()
