extends Camera2D


func _process(_delta):
#	if player == null:
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		position = player.position
