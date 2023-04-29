extends Area2D
var myNode = preload("../Player/player.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
  var myNode_instance =  myNode .instance() 
  get_tree().get_root().add_child(myNode_instance)
  myNode_instance.global_transform = global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
