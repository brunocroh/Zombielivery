extends CharacterBody2D

var speed = 100
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed


func _on_detection_area_area_entered(body):
	if body.is_in_group(GlobalScript.grupoPlayer):
		player = body
		player_chase = true
		


func _on_detection_area_area_exited(body):
	if body.is_in_group(GlobalScript.grupoPlayer):
		player = null
		player_chase = false
