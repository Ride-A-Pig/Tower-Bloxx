extends Camera2D

onready var p2d = $KinematicBody2D/Position2D
onready var pj2d = $KinematicBody2D/Position2D/PinJoint2D
onready var pj2d2 = $KinematicBody2D/Position2D/PinJoint2D2
onready var timer = $Timer
onready var rooms = $"/root/Main/Rooms"
onready var animation_player = $AnimationPlayer

var room_resource = preload("res://Scene/Room.tscn")
var new_room
var b_droppable = false

func _ready():
	timer.connect("timeout",self,"_on_timeout")

func _input(event):
	if event.is_action_pressed("ui_accept") and timer.is_stopped() and b_droppable:
		_release_room()
		timer.start()	

func _on_timeout():
	_spawn_room()

func _spawn_room():
	new_room = room_resource.instance()
	new_room.global_position = p2d.global_position
	get_node_or_null("/root/Main/Rooms").add_child(new_room)
	pj2d.node_b = new_room.get_path()
	pj2d2.node_b = new_room.get_path()
	b_droppable = true

func _release_room():
	if !new_room: return
	b_droppable = false
	pj2d.node_b = pj2d.node_a
	pj2d2.node_b = pj2d2.node_a
	new_room.linear_velocity = Vector2(0,0)
	if animation_player.playback_speed < 5:
		animation_player.playback_speed=1+0.02*GlobalValue.score
