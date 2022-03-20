extends Area2D


func _on_Exit_body_entered(body):
	if body.name == "Player":
		if name == "Exit_to_2":
			get_tree().change_scene("res://Levels/Game_Over.tscn")
