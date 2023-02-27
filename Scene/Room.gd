extends RigidBody2D

onready var asp = $AudioStreamPlayer
onready var judge = get_node_or_null("/root/Main/CanvasLayer/Judge")
onready var area_2d = $Area2D
onready var sprite = $Sprite

func _ready():
	connect("body_entered",self,"_on_body_entered")
	area_2d.connect("area_exited",self,"_on_disappear")
	sprite.frame = randi()%8
	_fade_in()

func _fade_in():
	sprite.modulate = Color(1,1,1,0)
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1,1,1,1), .1)
	
func _on_body_entered(body):
	GlobalValue._add_score()
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	var offset = abs(global_position.x-body.global_position.x)
	var tween = create_tween()
	tween.tween_property(judge,"rect_scale",Vector2(1.4,1.4),.05)
	tween.tween_property(judge,"rect_scale",Vector2(1.0,1.0),.05)
	if offset<=1:
		judge.text = "Perfect"
	elif offset<=3:
		judge.text = "Good"
	elif offset <= 6:
		judge.text = "Normal"
	else:
		judge.text = "Bad"
	if GlobalValue.score>=4:
		get_node_or_null("/root/Main/Camera2D").position.y-=20
	set_deferred("contact_monitor",false)
	asp.play()

func _on_disappear(_area):
	if linear_velocity.length()>100:
		_game_over()
	else:
		var tween = create_tween()
		tween.tween_property(self,"global_rotation_degrees", .0, .5)
		yield(tween,"finished")
		set_deferred("mode",RigidBody2D.MODE_STATIC)


func _game_over():
	get_tree().change_scene("res://Scene/Over.tscn")


