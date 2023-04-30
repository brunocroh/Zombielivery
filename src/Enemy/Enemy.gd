extends Area2D

var health = GlobalScript.healthBasicEnemy

func _ready():
	add_to_group(GlobalScript.grupoInimigo)
	

func _process(delta):
	var health = GlobalScript.healthBasicEnemy
	var helthbar = $EnemyHealth
	helthbar.value = health
	if health < 1:
		queue_free()
