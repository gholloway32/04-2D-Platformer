extends Node2D

onready var Player = load("res://Player/Player.tscn")
export var spawn_location = Vector2(200,200)


func _ready():
	pass


func _physics_process(_delta):
	var player = get_node_or_null("Player")
	if player == null:
		spawn(spawn_location)

func spawn(p):
	var player = Player.instance()
	player.position = p
	player.name = "Player"
	add_child(player)
