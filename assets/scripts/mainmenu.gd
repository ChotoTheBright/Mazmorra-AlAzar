extends Node

func first_person_mode():
	Init.player_mode = false#true
	get_tree().change_scene_to_file("res://Main.tscn")
	pass

func third_person_mode():
	Init.player_mode = false
	get_tree().change_scene_to_file("res://Main.tscn")
	pass
