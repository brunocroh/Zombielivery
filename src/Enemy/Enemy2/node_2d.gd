extends CharacterBody2D

var speed = 25
var playerChase = false
var player = null

func _physics_process(delta):
	if playerChase: 
		position += (player.position - position)/speed
	


func _on_detection_area_body_entered(body):
	player = body
	playerChase = true
	print("entrou")


func _on_detection_area_body_exited(body):
	player = null
	playerChase = false
	print("saiu")
