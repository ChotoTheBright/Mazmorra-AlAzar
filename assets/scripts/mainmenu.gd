extends Node



func first_person_mode():
	Init.player_mode = true
	get_tree().change_scene_to_file("res://Main.tscn")
	pass

func third_person_mode():
	Init.player_mode = false
	get_tree().change_scene_to_file("res://Main.tscn")
	pass


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Main.tscn")
	pass


func _on_button_2_pressed():
	pass # Replace with function body.
