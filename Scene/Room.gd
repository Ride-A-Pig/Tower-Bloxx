extends RigidBody2D

var cam_up = 0

onready var asp = $AudioStreamPlayer


func _ready():
	connect("body_entered",self,"_on_body_entered")
	$VisibilityNotifier2D.connect("screen_exited",self,"_on_disappear")
	
func _on_body_entered(body):
#	GlobalValue._add_score()
#	if GlobalValue.score>=4:
#		get_node_or_null("/root/Main/Camera2D").position.y-=20
	GlobalValue._add_score()
	cam_up = global_position.y-body.global_position.y
	if GlobalValue.score>=4:
		get_node_or_null("/root/Main/Camera2D").position.y+=cam_up
	set_deferred("contact_monitor",false)
	asp.play()


func _on_disappear():
	if linear_velocity.length()>100:
		_game_over()
	else:
		mode = RigidBody2D.MODE_STATIC
		
		
func _game_over():
	get_tree().change_scene("res://Scene/Over.tscn")
