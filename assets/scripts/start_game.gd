extends Node

@export var grid_size = 8 #even numbers for the grid provide best results
@onready var player = Init.player
@onready var tile = Init.tile
@onready var object = Init.object
@onready var worldbox = Init.worldbox
@onready var environment = $WorldEnvironment
@onready var rng = RandomNumberGenerator.new()
@onready var _collision_ = [] 
var trans

func _ready():
	Init.tilerng.randomize()
	Init.wallrng.randomize()
	Init.objrng.randomize()
	randomize()
	enter_grid()
	enter_objects()
	enter_player()
	enter_box()

func enter_player():
	var inst = player.instantiate()
	add_child(inst)
	inst.translate(Vector3(0,0,0))

func enter_grid():
	randomize()

	for x in range(grid_size):
		for y in range(grid_size):
			var inst = tile.instantiate()
			add_child(inst)
			@warning_ignore("integer_division")
			inst.translate(Vector3(x,0,y)-Vector3(grid_size,0,grid_size)/2)
			#set texture
			var ran_range = Init.tilerng.randi_range(0,8)
			var tex_name : String = Init.tile_textures[ran_range]#0
			@warning_ignore("int_as_enum_without_cast")
			Init.tilemat.set_texture(0,load("res://assets/images-fonts/RetroTextures/Floor/"+tex_name))

func enter_objects():
	for x in range(grid_size):
		for y in range(grid_size):
			rng = randi() % 100 - 1 
			if rng < 16: #Regarding the rng calulation:
			#x & y are multipled. by default its 64 (8x8 for grid size). a random
			#Int is generated 64 times, or whatever num the x & y multiplies to.
			#If the random num is greater than 16, an obj instance will spawn in.
			#For simpler math, I keep everything even and divisible by the default 
			#Grid Size, ie: 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96 etc
				var inst = object.instantiate()
				add_child(inst)
				@warning_ignore("integer_division")
				inst.translate(Vector3(x,0,y)-Vector3(grid_size,0,grid_size)/2)
				trans = inst.get_global_position()
				_collision_.append(trans)
				if trans == Vector3(0,1,0): #objs wont spawn on player
					inst.queue_free()
				#set texture
				var ran_range = Init.objrng.randi_range(0,13)
				var tex_name : String = Init.obj_textures[ran_range]
				@warning_ignore("int_as_enum_without_cast")
				Init.objectmat.set_texture(0,load("res://assets/images-fonts/RetroTextures/Objects/"+tex_name))

func enter_box():
	randomize()
	for x in range(grid_size):
		for y in range(grid_size):
			var w1 = worldbox.instantiate()
			var w2 = worldbox.instantiate()
			var w3 = worldbox.instantiate()
			var w4 = worldbox.instantiate()
			add_child(w1)
			add_child(w2)
			add_child(w3)
			add_child(w4)
			@warning_ignore("integer_division")
			w1.translate(Vector3(grid_size/2,1.0,y-grid_size/2))
			@warning_ignore("integer_division")
			w2.translate(Vector3(x-grid_size/2,1.0,grid_size/2))
			@warning_ignore("integer_division")
			w3.translate(Vector3(-grid_size/2-1,1.0,y-grid_size/2))
			@warning_ignore("integer_division")
			w4.translate(Vector3(x-grid_size/2,1.0,-grid_size/2-1))
			var boxtran1 = w1.get_global_position()
			var boxtran2 = w2.get_global_position()
			var boxtran3 = w3.get_global_position()
			var boxtran4 = w4.get_global_position()
			_collision_.append(boxtran1)
			_collision_.append(boxtran2)
			_collision_.append(boxtran3)
			_collision_.append(boxtran4)
			#set texture
			var ran_range = Init.wallrng.randi_range(0,11)
			var tex_name : String = Init.wall_textures[ran_range]
			@warning_ignore("int_as_enum_without_cast")
			Init.wallmat.set_texture(0,load("res://assets/images-fonts/RetroTextures/Walls/"+tex_name))
