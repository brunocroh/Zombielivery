extends Area2D

@onready var map = preload("res://src/Map/Map.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var mapa = map.instantiate()
	mapa.position = Vector2(0, 0)
	get_tree().current_scene.add_child(mapa)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
