extends Camera2D


onready var p2d = $KinematicBody2D/Position2D
onready var pj2d = $KinematicBody2D/Position2D/PinJoint2D
onready var pj2d2 = $KinematicBody2D/Position2D/PinJoint2D2
onready var timer = $Timer
onready var rooms = $"/root/Main/Rooms"
onready var animation_player = $AnimationPlayer



var room_resource = preload("res://Scene/Room.tscn")
var count = 0
var new_room

func _ready():
	randomize()
	_spawn_room()
	timer.connect("timeout",self,"_on_timeout")


func _input(event):
	if event.is_action_pressed("ui_accept") and timer.is_stopped():
		_release_room()
		timer.start()
#		if GlobalValue.score >= 4:
#			position.y-=20
		
		

func _spawn_room():
	new_room = room_resource.instance()
	new_room.get_node("Sprite").frame = randi()%8
	new_room.global_position = p2d.global_position
	get_node_or_null("/root/Main/Rooms").call_deferred("add_child",new_room)
	yield(get_tree(),"idle_frame")
	pj2d.node_b = new_room.get_path()
	pj2d2.node_b = new_room.get_path()
	var old_rooms = get_node_or_null("/root/Main/Rooms").get_children()

func _release_room():
	pj2d.set_deferred("node_b",pj2d.node_a)
	pj2d2.set_deferred("node_b",pj2d2.node_a)
	new_room.linear_velocity = Vector2(0,0)
	animation_player.playback_speed=1+0.02*GlobalValue.score
	animation_player.playback_speed = clamp(animation_player.playback_speed,0,3)

func _on_timeout():
	_spawn_room()

#func _process(delta):
#	var all_rooms = rooms.get_children()
#	var top_value = 0
#	for i in all_rooms:
#		if i.position.y<top_value:
#			top_value = i.position.y
#	position.y = top_value-40
