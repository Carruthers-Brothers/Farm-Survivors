class_name Seed extends Node2D

@onready var sprite_2d = $Sprite2D

const _1_COMMON_SEED = preload("res://Assets/1-Common_Seed.png")
const _2_UNCOMMON_SEED = preload("res://Assets/2-UncommonSeed.png")
const _3_RARE_SEED = preload("res://Assets/3-RareSeed.png")
const _4_EPIC_SEED = preload("res://Assets/4-EpicSeed.png")
const _5_LEGENDARY_SEED = preload("res://Assets/5-LegendarySeed.png")

var seed_type = "Common" # default to common

func set_type(name):
	seed_type = name
	match name:
		"Common":
			sprite_2d.texture = _1_COMMON_SEED
		"Uncommon":
			sprite_2d.texture = _2_UNCOMMON_SEED
		"Rare":
			sprite_2d.texture = _3_RARE_SEED
		"Epic":
			sprite_2d.texture = _4_EPIC_SEED
		"Legendary":
			sprite_2d.texture = _5_LEGENDARY_SEED
		_:
			sprite_2d.texture = _1_COMMON_SEED
