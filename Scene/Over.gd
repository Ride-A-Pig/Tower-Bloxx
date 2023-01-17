extends Control

func _ready():
	$Label2.text = "Score: "+String(GlobalValue.score)
	
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Scene/MainScene.tscn")
		GlobalValue.score = 0
