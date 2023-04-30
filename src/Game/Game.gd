extends Area2D

@onready var map = preload("res://src/Map/Map.tscn")
var Game

var tileSize = 864
var renderedTiles = []
var oldRenderedTiles = []

func _on_area_exited(_area: Area2D, mapa):
  var x = mapa.position.x
  var y = mapa.position.y

  oldRenderedTiles = renderedTiles
  renderedTiles = []

  create_tiles(x, y)

  for n in oldRenderedTiles:
    if n != null:
      get_tree().current_scene.remove_child(n)
      n.queue_free()



func createTile(x, y):
  var mapa = map.instantiate()
  mapa.position = Vector2(x, y)
  mapa.area_exited.connect(func(area): _on_area_exited(area, mapa))
  get_tree().current_scene.call_deferred('add_child', mapa)
  return mapa

func create_tiles(x, y):

  # A1 A2 A3 A4 A5
  # B1 B2 B3 B4 B5   
  # C1 C2 C3 C4 C5


  # B1
  renderedTiles.push_back(createTile(x + ( 2 * ( tileSize * -1 ) ), y))
  # B4
  renderedTiles.push_back(createTile(x + tileSize, y))

  # B1
  renderedTiles.push_back(createTile(x - tileSize, y))

  renderedTiles.push_back(createTile(x + ( 2 * tileSize ), y))

  renderedTiles.push_back(createTile(x, y + tileSize))
  renderedTiles.push_back(createTile(x, y - tileSize))

  renderedTiles.push_back(createTile(x, y + ( 2 * tileSize )))
  renderedTiles.push_back(createTile(x, y + ( 2 * ( tileSize * -1 ) )))


  # B3
  renderedTiles.push_back(createTile(x, y))

# Called when the node enters the scene tree for the first time.
func _ready():
  Game = get_tree().current_scene
  create_tiles(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
