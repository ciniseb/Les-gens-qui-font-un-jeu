extends Area2D

var level = 1
var hp = 2
var knockback = 100
var speed = 250
var damage = 5
var attack_size = 1.0
var direction = Vector2.ZERO
@onready var animation = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("joueur")

signal remove_from_array(object)
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("active_spell") #fait jouer l'animation
	global_position = player.global_position
	#calcule la direction entre le joueur et la sourie
	direction = global_position.direction_to(get_global_mouse_position())
	rotation = direction.angle()
	
func ajust_level():
	match level:
		1:
			var hp = 2
			var knock_back = 100
			var speed = 100
			var damage = 5
			var attack_size = 1.0

func _physics_process(delta):
	global_position += direction*speed*delta
	pass
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()


func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
