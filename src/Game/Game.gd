extends Area2D

@onready var map = preload("res://src/Map/Map.tscn")
var Game

var tileSize = 864
var renderedTiles = []
var oldRenderedTiles = []

var dicTiles = {
  "-864,-864": "rendered",
}

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



func createTile(x, y):
  var mapa = map.instantiate()
  mapa.position = Vector2(x, y)
  mapa.area_exited.connect(func(area): _on_area_exited(area, mapa))
  get_tree().current_scene.call_deferred('add_child', mapa)
  return mapa

func create_tiles(x, y):

  # Z1 Z2 Z3 Z4 Z5
  # A1 A2 A3 A4 A5
  # B1 B2 B3 B4 B5   
  # C1 C2 C3 C4 C5
  # D1 D2 D3 D4 D5

  for i in range(-1, 4):
    for j in range(-1, 4):
      var _x = x + (i - 1) * tileSize
      var _y = y + (j - 1) * tileSize
      var dicKey = str(_x, ',', _y)
      if (dicTiles.has(dicKey)):
        print('rerender')
      else: 
        dicTiles[dicKey] = 'rendered'

      renderedTiles.append(
        createTile(x + (i - 1) * tileSize, y + (j - 1) * tileSize)    
      )

  dicTiles = {}

# Called when the node enters the scene tree for the first time.
func _ready():
  Game = get_tree().current_scene
  create_tiles(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
