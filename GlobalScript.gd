extends Node

const grupoInimigo = "inimigo"
const grupoPlayer = "player"

var healthGlobalPlayer = 20
var currentPlayerDamage = 1

var healthBasicEnemy = 2
var damageBasicEnemy = 2

func damageTake() -> void:
	healthGlobalPlayer -= damageBasicEnemy

func damageDone() -> void:
	healthBasicEnemy -= currentPlayerDamage
