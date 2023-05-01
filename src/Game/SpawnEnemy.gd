var enemy
var renderedEnemies = []

var rng
var getTree

signal enemy_dead

func _init():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	enemy = preload("res://src/Enemy/Enemy.tscn")

func on_enemy_health_depleted(_enemy):
	print('enemy')
	getTree.current_scene.call_deferred('remove_child', _enemy)
	_enemy.call_deferred('queue_free')
	enemy_dead.emit()

func on_enemy_dead(_enemy):
	getTree.current_scene.call_deferred('remove_child', _enemy)
	_enemy.call_deferred('queue_free')

func spawn_enemy(x, y, deal_damage):
	var _enemy = enemy.instantiate()
	var angle = rng.randi_range(0, 360)
	var direction = Vector2(cos(angle), sin(angle))
	_enemy.position = Vector2(x, y) + direction * 2000
	_enemy.health_depleted.connect(func(): on_enemy_health_depleted(_enemy))
	_enemy.enemy_attack.connect(deal_damage)
	_enemy.health_dead.connect(func(_area): on_enemy_dead(_enemy))

	getTree.current_scene.call_deferred('add_child', _enemy)
	return _enemy

func enemies(x, y, deal_damage): 
	for i in range(2):
		renderedEnemies.append(
			spawn_enemy(x, y, deal_damage)
		)
