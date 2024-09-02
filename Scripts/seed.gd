class_name Seed extends Node2D

@onready var sprite_2d = $Sprite2D

const _1_COMMON_SEED = preload("res://Assets/1-Common_Seed.png")
const _2_UNCOMMON_SEED = preload("res://Assets/2-UncommonSeed.png")

var seed_type = "Common" # default to common

func set_type(name):
	seed_type = name
	match name:
		"Common":
			sprite_2d.texture = _1_COMMON_SEED
		"Uncommon":
			sprite_2d.texture = _2_UNCOMMON_SEED
		_:
			sprite_2d.texture = _1_COMMON_SEED
