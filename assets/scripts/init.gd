extends Node

@onready var tile = preload("res://scenes/Tile.tscn")
@onready var tilemat = preload("res://assets/TileMat.tres")
@onready var tilerng = RandomNumberGenerator.new()
##
@onready var worldbox = preload("res://scenes/WorldBox.tscn")
@onready var wallmat = preload("res://assets/WorldBoxMat.tres")
@onready var wallrng = RandomNumberGenerator.new()
##
@onready var object = preload("res://scenes/Object.tscn")
@onready var objectmat = preload("res://assets/ObjectMat.tres")
@onready var objrng = RandomNumberGenerator.new()
#textures#
@onready var tile_textures = []
@onready var obj_textures = []
@onready var wall_textures = []
#music/sfx#


func _ready():
	var dir = DirAccess.open("res://assets/images-fonts/RetroTextures/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("beep boop")
			else:
				if file_name.begins_with("FLOOR_") and file_name.ends_with("png"):
					tile_textures.append(file_name)
					#print("Found file: " + file_name)
				if file_name.begins_with("BRICK_") and file_name.ends_with("png"):
					wall_textures.append(file_name)
				if !file_name.begins_with("FLOOR_") and !file_name.begins_with("BRICK_") and file_name.ends_with("png"):
					obj_textures.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
