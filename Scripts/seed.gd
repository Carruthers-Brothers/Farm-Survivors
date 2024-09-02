class_name Seed extends Node2D

@onready var sprite_2d = $Sprite2D

const _1_COMMON_SEED = preload("res://Assets/2-UncommonSeed.png")
const _2_UNCOMMON_SEED = preload("res://Assets/pine_seed.png")

var seed_type = "Common" # default to common

func set_type(name):
	seed_type = name
	match name:
		"Common":
			sprite_2d.texture = _1_COMMON_SEED
		"Uncommon":
			sprite_2d.texture = _2_UNCOMMON_SEED
			sprite_2d.scale.x *= 2
			sprite_2d.scale.y *= 2
		_:
			sprite_2d.texture = _1_COMMON_SEED
