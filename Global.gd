extends Node


var score = 0
var lives = 5
var max_lives = 5
var health = 100
var max_health = 100
var level = 1
var death_zone = 1000
var levels = [
	"res://Levels/Level1.tscn"
	,"res://Levels/Level2.tscn"
	,"res://Levels/Level3.tscn"
	,"res://Levels/secretlevel.tscn"
]

var saves = [
	"user://game-data_0.json"
]

func get_save_data():
	var data = {
		"score":score
		,"lives":lives
		,"health":health 
		,"level":level
		,"player":""
		,"coins":[]
	}
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		data["player"] = var2str(player.position)
	var coins = get_node("/root/Game/Coin_Container").get_children()
	for c in coins:
		var temp = {"position":var2str(c.position), "score":c.score}
		data["coins"].append(temp)
	return data

func load_save_data(data):
	score = data["score"]
	lives = data["lives"]
	health = data["health"]
	level = data["level"]
	
	#get_tree().change_scene(levels[level])
	#call_deferred("load_save_data", data)
	##
	if data["player"] != "":
		var player = get_node_or_null("/root/Game/Player_container/Player")
		if player != null:
			player.queue_free()
		get_node("/root/Game/Player_Container").spawn(str2var(data["player"]))
	
	var coin_container = get_node("/root/Game/Coin_Container")
	for c in coin_container.get_children():
		c.queue_free()
	for c in data["coins"]:
		var attr = {"score":c["score"]}
		coin_container.spawn(attr, str2var(c["position"]))




#func _physics_process(_delta):
#	if fade == null:
#		fade = get_node_or_null("/root/Game/Camera/Fade")
#	if fade_out != "":
#		execute_fade_out(fade_out)
#	if fade_in:
#		execute_fade_in()
#		

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true

func increase_score(s):
	score += s

func decrease_health(h):
	health -= h 


func decrease_lives(l):
	lives -= l
	health = max_health
	if lives<= 0:
		get_tree().change_scene("res://Levels/Game_lost.tscn")

func save_game(which_file):
	var file = File.new()
	var data =get_save_data()
	file.open(saves[which_file], File.WRITE)
	file.store_string(to_json(data))
	file.close()
	
func load_game(which_file):
	var file = File.new()
	if file.file_exists(saves[which_file]):
		file.open(saves[which_file], File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			pass
		else:
			printerr("corrupted data")
	else:
		printerr("no saved data")

