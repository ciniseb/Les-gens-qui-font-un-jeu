extends CharacterBody2D

#ms = movement speed
@export var ms = 100.0

@onready var sprite = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("joueur")
@onready var anim

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*ms
	move_and_slide()
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false
		
	
