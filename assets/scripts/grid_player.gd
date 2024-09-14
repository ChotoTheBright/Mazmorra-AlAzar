extends CharacterBody3D

@onready var collision_node = get_node("/root/MAIN")
@onready var button_duration = $Timer
@onready var body = $Mesh
@onready var arm

var speed = 5
var angle_speed = 10
var current_dir = Vector3()
var next_pos = Vector3()
var destination = Vector3()
var can_move = false

#Player inits moved to start_game script, in enter_player func.

func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	position = position.move_toward(destination, speed * delta)
	body.rotation.y = lerp_angle(body.rotation.y, atan2(-next_pos.x, -next_pos.z), delta * angle_speed)

	if !position + Vector3.FORWARD in collision_node._collision_:
		if Input.is_action_just_pressed("ui_up") and button_duration.is_stopped():
			next_pos = Vector3.FORWARD
			current_dir = "up"
			can_move = true
			button_duration.start()
	if !position + Vector3.BACK in collision_node._collision_:
		if Input.is_action_just_pressed("ui_down") and button_duration.is_stopped():
			next_pos = Vector3.BACK
			current_dir = "down" 
			can_move = true
			button_duration.start()
	if !position + Vector3.RIGHT in collision_node._collision_:
		if Input.is_action_just_pressed("ui_right") and button_duration.is_stopped():
			next_pos = Vector3.RIGHT
			current_dir = "right"
			can_move = true
			button_duration.start()
	if !position + Vector3.LEFT in collision_node._collision_:
		if Input.is_action_just_pressed("ui_left") and button_duration.is_stopped():
			next_pos = Vector3.LEFT
			current_dir = "left"
			can_move = true
			button_duration.start()

	if position.distance_to(destination) <= 0.000 and can_move:
		destination = position + (next_pos)
		can_move = false
