class_name MusicKey
extends Control

@onready var key: ColorRect = $Key
@onready var start_color: Color = key.color
@onready var color_timer: Timer = $ColorTimer

var pitch_scale: float


func setup(pitch_index: int):
	name = "MusicKey" + str(pitch_index)
	var exponent := (pitch_index - 69.0) / 12.0
	pitch_scale = pow(2, exponent)
	print(pitch_scale)

func activate():
	key.color = (Color.DARK_RED + start_color) / 2
	var audio := AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = preload("res://Assets/chip1.wav")
	audio.pitch_scale = pitch_scale
	audio.play()
	color_timer.start()
	await get_tree().create_timer(8.0).timeout
	audio.queue_free()

func deactivate():
	key.color = start_color
