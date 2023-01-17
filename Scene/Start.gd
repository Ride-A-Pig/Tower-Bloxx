extends Control

onready var timer = $Timer
onready var ap = $AnimationPlayer

func _ready():
	timer.connect("timeout",self,"_on_timeout")



func _on_timeout():
	ap.play("Start")
	yield(ap,"animation_finished")
	get_tree().change_scene("res://Scene/MainScene.tscn")
