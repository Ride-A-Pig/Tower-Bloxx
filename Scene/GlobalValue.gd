extends Node
class_name Global

var health = 5

var score = 0



func _take_damage():
	health-=1
	if health<=0:
		print("No health")


func _add_score():
	score+=1
	print(score)
	get_node_or_null("/root/Main/CanvasLayer/Score").text = String(score)

func _remove_socre():
	score-=1
