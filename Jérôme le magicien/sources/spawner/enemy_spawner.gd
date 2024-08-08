extends Node2D

@export var spawns: Array[Spawn_info] = []

@onready var joueur = get_tree().get_first_node_in_group("joueur")

var time = 0

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	# a changer pour opti pcq jesus que c'est pas optimal (faire un 
	for i in enemy_spawns:
		if time > i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = load(str(i.enemy.resource_path))
				# Spawn le nombre d'enemy donnée dans la variable
				for j in i.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					
func get_random_position():
	# vpr = viewport rect
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(joueur.global_position.x - vpr.x/2, joueur.global_position.y - vpr.y/2)	
	var top_right = Vector2(joueur.global_position.x + vpr.x/2, joueur.global_position.y - vpr.y/2)
	var bottom_left = Vector2(joueur.global_position.x - vpr.x/2, joueur.global_position.y + vpr.y/2)
	var bottom_right = Vector2(joueur.global_position.x + vpr.x/2, joueur.global_position.y + vpr.y/2)
	
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 =  Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
