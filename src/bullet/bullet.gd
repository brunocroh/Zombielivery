extends CharacterBody2D


var veloc = Vector2(0,0)
var speed = 600

func _ready():
	add_to_group(GlobalScript.grupoPlayer)

func _physics_process(delta):
	
	var collision_info = move_and_collide(veloc.normalized() * delta * speed)