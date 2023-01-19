extends Node

var score = 0

func _add_score():
	score+=1
	get_node_or_null("/root/Main/CanvasLayer/Score").text = String(score)
