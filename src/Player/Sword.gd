extends CollisionShape2D

func _ready():
	add_to_group(GlobalScript.grupoPlayer)

func _on_area_2d_area_entered(area):
	if area.is_in_group(GlobalScript.grupoInimigo):
		GlobalScript.damageDone()
