@tool
extends Control

var mouse_on_pet = false
var target : Vector2 = Vector2.ZERO
var sprite_size : Vector2 = Vector2.ZERO

var default_speed = 250
var panic_speed = 750

var click_amount = 0

enum Instruction {
	STOP,
	IDLE,
	MOVING,
	PANIC,
}

var current_instruction = Instruction.IDLE
var running_in_scene_editor = false

func _ready():
	# If we are modifying this script then don't process this script inside the scene editor
	running_in_scene_editor = get_parent() is Viewport
	
	if not running_in_scene_editor:
		$AnimatedSprite.play("move")
	else:
		set_process(false)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if mouse_on_pet and not current_instruction == Instruction.PANIC:
				# Stop the pet from moving
				current_instruction = Instruction.STOP
				
				# Keep a count of clicks to check to see when panic mode can start
				click_amount += 1
				if click_amount >= 5:
					click_amount = 0
					current_instruction = Instruction.PANIC
					$PanicTimer.start()
				else:
					# Starts the cancel panic timer
					# If the timer is running, then it will restart it
					$CancelPanicTimer.start()
		elif event.button_index == 1 and not event.pressed:
			# Allow the pet to move if we are not in panic mode
			if current_instruction == Instruction.STOP:
				current_instruction = Instruction.IDLE

func set_sprite_size():
	var frame = $AnimatedSprite#.sprite_frames.get_frame_count("move")#sprite_frames.
	size = frame.get_size()
	sprite_size = frame.get_size() * scale

func set_texture_flags_to_none():
	var frameCount = $AnimatedSprite.sprite_frames.get_frame_count("move")
	for i in frameCount:
		var frame = $AnimatedSprite.sprite_frames.set_frame(i)
		frame.flags = 0

func _process(delta):
	$AnimatedSprite.flip_h = target.x - position.x > 0

	if current_instruction == Instruction.IDLE:
		if randf() < 0.01:
			current_instruction = Instruction.MOVING
			
			target.x = randf_range(0, get_viewport_rect().size.x - sprite_size.x)
			target.y = randf_range(0, get_viewport_rect().size.y - sprite_size.y)

	if current_instruction == Instruction.MOVING:
		position = position.move_toward(target, default_speed * delta)
		if position == target:
			current_instruction = Instruction.IDLE
	
	if current_instruction == Instruction.PANIC:
		if randf() < 0.1:
			target.x = randf_range(0, get_viewport_rect().size.x - sprite_size.x)
			target.y = randf_range(0, get_viewport_rect().size.y - sprite_size.y)
		position = position.move_toward(target, panic_speed * delta)
	
	if mouse_on_pet and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		position = get_global_mouse_position() - (sprite_size / 2)
		
		# Clamp the position so it doesn't go off screen
		position.x = clamp(position.x, 0, get_viewport_rect().size.x - sprite_size.x)
		position.y = clamp(position.y, 0, get_viewport_rect().size.y - sprite_size.y)

func _on_Pet_mouse_entered():
	mouse_on_pet = true

func _on_Pet_mouse_exited():
	mouse_on_pet = false

func _on_PanicTimer_timeout():
	current_instruction = Instruction.IDLE

func _on_CancelPanicTimer_timeout():
	click_amount = 0
