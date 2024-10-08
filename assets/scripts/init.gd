extends Node
#putting everything in here as a MACRO
@onready var player = preload("res://Scenes/player.tscn")
@onready var tile = preload("res://Scenes/Tile.tscn")
@onready var tilemat = preload("res://Assets/Tile_Mat.tres")
@onready var tilerng = RandomNumberGenerator.new()
##
@onready var worldbox = preload("res://Scenes/WorldBox.tscn")
@onready var wallmat = preload("res://Assets/WorldBox_Mat.tres")
@onready var wallrng = RandomNumberGenerator.new()
##
@onready var object = preload("res://Scenes/Object.tscn")
@onready var objectmat = preload("res://Assets/Object_Mat.tres")
@onready var objrng = RandomNumberGenerator.new()
#textures#
@onready var tile_textures = []
@onready var obj_textures = []
@onready var wall_textures = []

@onready var player_mode : bool = false


func _ready():
	var dir_floor = DirAccess.open("res://Assets/images-fonts/RetroTextures/Floor")
	var dir_walls = DirAccess.open("res://Assets/images-fonts/RetroTextures/Walls")
	var dir_objs = DirAccess.open("res://Assets/images-fonts/RetroTextures/Objects")
	var file_name_floor
	var file_name_wall
	var file_name_obj

	if dir_floor:
		dir_floor.list_dir_begin()
		file_name_floor = dir_floor.get_next()
		while file_name_floor != "":
			if dir_floor.current_is_dir():
				print("beep boop")
			else:
				if file_name_floor.begins_with("FLOOR_") and file_name_floor.ends_with("png"):
					tile_textures.append(file_name_floor)
			file_name_floor = dir_floor.get_next()

	if dir_walls:
		dir_walls.list_dir_begin()
		file_name_wall = dir_walls.get_next()
		while file_name_wall != "":
			if dir_walls.current_is_dir():
				print("beep boop")
			else:
				if file_name_wall.begins_with("BRICK_") and file_name_wall.ends_with("png"):
					wall_textures.append(file_name_wall)
			file_name_wall = dir_walls.get_next()

	if dir_objs:
		dir_objs.list_dir_begin()
		file_name_obj = dir_objs.get_next()
		while file_name_obj != "":
			if dir_objs.current_is_dir():
				print("beep boop")
			else:
				if !file_name_obj.begins_with("FLOOR_") and !file_name_obj.begins_with("BRICK_") and file_name_obj.ends_with("png"):
					obj_textures.append(file_name_obj)
			#file_name = dir.get_next()
			file_name_obj = dir_objs.get_next()
	else:
		print("An error occurred when trying to access the path.")
