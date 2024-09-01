extends "res://Scripts/Weapons/weapon.gd"

var rotation_speed = 4
var damage = 10
var upgrade_name = "Scythe"
var description = "Weapon that rotates around player constantly"

func _ready():
	level = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# the base in the center is actually a marker, so it rotates around that
	rotation_speed = get_parent().attack_speed # getting attack speed from player
	self.global_rotation += rotation_speed * delta


func _on_area_2d_area_entered(area):
	var enemy = area.get_parent() # damage enemies
	if enemy.has_method("take_damage"):
		enemy.call_deferred("take_damage", damage)
		
		
func apply_upgrade(player):
	if level == 1:
		player.add_child(self)
	elif level == 2:
		damage += 5
	elif level == 3:
		damage += 10
