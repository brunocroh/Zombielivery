extends Area2D

var health = 2

func _ready():
	pass # Replace with function body.


func _process(delta):
	var helthbar = $EnemyHealth
	helthbar.value = health



func _on_area_entered(area):
	health = health - 1
	if health < 1:
		queue_free()
