extends Node

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Main.tscn")
	pass
