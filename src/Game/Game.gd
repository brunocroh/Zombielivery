extends Area2D

@onready var map = preload("res://src/Map/Map.tscn")
@onready var enemy = preload("res://src/Enemy/Enemy.tscn")

var tileSize = 864
var renderedEnemies = []
var renderedTiles = []
var oldRenderedTiles = []

var dicTiles = {}

func on_enemy_health_depleted(_enemy):
  print('enemy')
  get_tree().current_scene.call_deferred('remove_child', _enemy)
  _enemy.call_deferred('queue_free')


func _on_area_exited(_area: Area2D, mapa):
  var x = mapa.position.x
  var y = mapa.position.y

  oldRenderedTiles = renderedTiles
  renderedTiles = []

  create_tiles(x, y)

  for n in oldRenderedTiles:
    if n != null:
      get_tree().current_scene.call_deferred('remove_child', n)
      n.queue_free()

func create_tile(x, y):
  var mapa = map.instantiate()
  mapa.position = Vector2(x, y)
  mapa.area_exited.connect(func(area): _on_area_exited(area, mapa))
  get_tree().current_scene.call_deferred('add_child', mapa)
  return mapa

func create_tiles(x, y):
  for i in range(-1, 4):
    for j in range(-1, 4):
      var _x = x + (i - 1) * tileSize
      var _y = y + (j - 1) * tileSize
      var dicKey = str(_x, ',', _y)
      if (not dicTiles.has(dicKey)):
        dicTiles[dicKey] = 'rendered'

        renderedTiles.append(
          create_tile(x + (i - 1) * tileSize, y + (j - 1) * tileSize)    
        )

        dicTiles = {}

func spawn_enemy(x, y):
  var _enemy = enemy.instantiate()
  _enemy.position = Vector2(x, y)
  _enemy.health_depleted.connect(func(): on_enemy_health_depleted(_enemy))
  get_tree().current_scene.call_deferred('add_child', _enemy)
  return _enemy

# Called when the node enters the scene tree for the first time.
func _ready():
  create_tiles(0, 0)
  renderedEnemies.append(
    spawn_enemy(10, 10)
)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
