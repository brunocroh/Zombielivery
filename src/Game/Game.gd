extends Area2D

@onready var map = preload("res://src/Map/Map.tscn")
@onready var mapa1 = preload("res://src/Mapa/Mapa4.tscn")
@onready var mapa2 = preload("res://src/Mapa/Mapa5.tscn")
@onready var mapa3 = preload("res://src/Mapa/Mapa6.tscn")
@onready var player = preload("res://src/Player/Player.tscn")
@onready var enemy = preload("res://src/Enemy/Enemy.tscn")
@onready var treasure = preload("res://src/Objective/Treasure.tscn")

var rng = RandomNumberGenerator.new()

var spawnEnemy = preload("./SpawnEnemy.gd").new()
var actualPlayer
var _treasure
var arrow
var exp = 0
var XpBar


var tileSize = 864 * 3 - 290
var renderedTiles = []
var oldRenderedTiles = []

var dicTiles = {}

func compass():
  if not is_instance_valid(arrow):
    arrow = self.find_child('Arrow')

  var diff =   _treasure.position - actualPlayer.position
  arrow.rotation = diff.angle()  - PI/2
  arrow.flip_h = true

func create_objetive():
  _treasure = treasure.instantiate()
  _treasure.position = Vector2(2500, 5000)
  get_tree().current_scene.call_deferred('add_child', _treasure)

func on_enemy_health_depleted(_enemy):
  get_tree().current_scene.call_deferred('remove_child', _enemy)
  _enemy.call_deferred('queue_free')

func _on_body_exited(_area: CharacterBody2D, mapa):
  var x = mapa.position.x
  var y = mapa.position.y

  print(x,y)

  oldRenderedTiles = renderedTiles
  renderedTiles = []

  create_tiles(x, y)

  for n in oldRenderedTiles:
    if n != null:
      get_tree().current_scene.call_deferred('remove_child', n)
      n.queue_free()

func create_player():
  var _player = player.instantiate()
  _player.position = Vector2(0, 0)
  get_tree().current_scene.call_deferred('add_child', _player)
  return _player

func create_tile(x, y):
  var dicKey = str(x, ',', y)
  var mapas = [mapa1, mapa2, mapa3]

  var value

  if dicTiles.has(dicKey):
    value = dicTiles[dicKey]
  else:
    value = rng.randi_range(0, 2)
    dicTiles[dicKey] = value


  var actualMap = mapas[value].instantiate()

  actualMap.position = Vector2(x, y)
  actualMap.body_exited.connect(func(body): _on_body_exited(body, actualMap))
  get_tree().current_scene.call_deferred('add_child', actualMap)
  return actualMap

func create_tiles(x, y):
  print('create_tile')
  for i in range(-1, 4):
    for j in range(-1, 4):
      var _x = x + (i - 1) * tileSize
      var _y = y + (j - 1) * tileSize
      renderedTiles.append(
        create_tile(x + (i - 1) * tileSize, y + (j - 1) * ( tileSize - 126 ))    
      )


func deal_damage(damage):
  actualPlayer.damage_take(damage)

func listen_enemy_dead():
# Called when the node enters the scene tree for the first time.
  exp = exp + 1
  $HUD/ExpBar.value = exp
  if exp >= 10:
    exp = 0
    $HUD/AnimatedSprite2D.play("Level2")
  spawnEnemy.enemies(
    actualPlayer.position.x,
    actualPlayer.position.y,
    deal_damage
  )

# Called when the node enters the scene tree for the first time.
func _ready():
  rng.randomize()
  create_objetive()
  create_objetive()
  spawnEnemy.getTree = get_tree()
  $HUD/AnimatedSprite2D.play("Level1")

  actualPlayer = create_player()
  create_tiles(0, 0)
  spawnEnemy.enemies(0, 0, deal_damage)
  spawnEnemy.enemy_dead.connect(listen_enemy_dead)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  compass()
