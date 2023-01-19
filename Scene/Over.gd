extends Control

const save_resource = "res://Scene/GameSaver.gd"
const save_path = preload("res://Scene/GameSaver.gd").save_path

func _ready():
	$Label2.text = "Score: "+String(GlobalValue.score)
	if !ResourceLoader.exists(save_path):
		ResourceSaver.save(save_path,load(save_resource).new())
		
	var read = ResourceLoader.load(save_path)
	if GlobalValue.score > read.high_score:
		read.high_score = GlobalValue.score
		ResourceSaver.save(save_path,read)
	$Label3.text = "Highest: "+String(read.high_score)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Scene/MainScene.tscn")
		GlobalValue.score = 0
